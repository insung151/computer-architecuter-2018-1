	//---------------------------------------------------------
//
// Project #1: TinyFP Representation
//
// March 22, 2018
//
// Jin-Soo Kim (jinsoo.kim@snu.ac.kr)
// Systems Software Laboratory
// Dept. of Computer Science and Engineering
// Seoul National University
//
//---------------------------------------------------------


#include "pa1.h"

tinyfp int2tinyfp(int x)
{
//    tinyfp 표현 범위 초과 INF
	if (x > 240)
		return 0b01111000;
	else if(x < -240){
		return 0b11111000;
	}
//    결과를 저장할 변수
	tinyfp result = 0;
//    sign bit
	int msb = x >> 31 & 1;
//    음수일 경우 2's complement
	if ( msb == 1){
		x = ~x + 1;
	}
//    sign bit 제거
    x = x << 1;
    if (x  == 0){
        return 0;
    }

	int exp = 30 + 7;
//    처음으로 0이아닌 비트가 나올 때 까지 왼쪽으로 shifting
    while ((x >> 31 & 1) != 1){
        x = x << 1;
        exp --;
    }
//    가장 sign bit 제거 후 오른쪽으로 29 shifting해서  3자리만 남김
	int frac = (unsigned int)(x << 1) >> 29;
//    msb, exp, frac을 각각 위치에 맞게 shifting 한 후 넣어줌
	result = (tinyfp)(msb << 7) | result;
	result = (tinyfp)(exp << 3) | result;
	result = (tinyfp) frac | result;
	return result;
}


int tinyfp2int(tinyfp x)
{
    int result = 0;
//    sign bit
    int msb = x >> 7 & 1;
// NaN  or INF case
    if ( (x & 0x78) == 0x78){
        result = 0x80000000;
        return result;
    }
//    x 가  +-0
    if (!(tinyfp)(x << 1)){
        return 0;
    }
//    exp bits 읽어서 - bias(7)
    int exp = ((x & 0b01111000) >> 3) - 7;
//    frac bits 읽어서 앞에 1붙여줌
    int frac = (x & 0b00000111) | 0b1000;

//    frac bits가 3자리라서 exp가 3보다 클때랑 작을때로 나눠서함
//    0 보다 작으면 return 0
    if (exp >= 3) {
        result = frac << (exp - 3) | result;
    }else if(exp >=0){
        result = frac >> (3 - exp) | result;
    }
//    음수이면 2's complement
    if (msb == 1){
        result = ~result + 1;
    }
    return result;
}


tinyfp float2tinyfp(float x)
{
//    tinyfp 표현범위 초과 +-INF
    if (x > 240)
        return 0b01111000;
    else if(x < -240){
        return 0b11111000;
    }
    union _union{
        unsigned int i;
        float f;
    } u;
    u.f = x;
//    sign bit
    int msb = u.i >> 31 & 1;
    tinyfp result = 0;
    result = (tinyfp) (msb << 7) | result;
//    exp 비트가 모두 1인경우
    if ((u.i & 0x7F800000) == 0x7F800000){
//      나머지 비트들은 0일때 INF (사실 위에 범위 초과에 걸림)
        if ((u.i & 0x007FFFFF) == 0){
            return (tinyfp) 0x78 | result;
        }
//      NaN
        else{
            return (tinyfp) 0x79 | result;
        }
    }
    int exp = ((u.i & 0x7F800000) >> 23);
//    exp 비트가 0일때(denormalized) tinyfp로 표현하기엔 너무 작음 return 0
    if (exp == 0){
        return result;
    }
//    normalizing
    exp += -127 + 7;
//    frac 비트가 3자리라서 exp -3 이하는 0
    if (exp < -2){
        return result;
    }
//  exp가 -1,-2,0 일때tinyfp denormalized form으로 표현가능
    else if(exp<=0){
        int frac = u.i & 0x7FFFFF | 0x800000 ;
        result = (tinyfp) (frac >> (21 - exp)) | result;
        return result;
    }
    else{
        int frac = (u.i & 0x7FFFFF) >> 20;
        result = (tinyfp) (exp << 3)| result;
        result = (tinyfp) frac | result;
        return result;
    }

}


float tinyfp2float(tinyfp x)
{
    union _union{
        unsigned int i;
        float f;
    } u;

    u.i = 0;
//  sign bit
    int msb = x >> 7 & 1;
    u.i = (msb << 31) | u.i ;
//  exp 비트가 모두 1 일때
    if ( (x & 0x78) == 0x78){
//      NaN
        if( (x & 0b111) == 0){
            u.i =  0x7F800000 | u.i;
            return u.f;
        }
//      INF
        else{
            u.i = 0x7F800001 | u.i;
            return u.f;
        }
    }

    int exp = (x & 0b01111000) >> 3;
//   denormalized case
    if (exp == 0) {
        int frac = x & 0b00000111;
        if (((frac >> 2) & 1) == 1 ){
            frac = frac ^ 0b100;
            exp = -7 + 127;
            u.i = (frac << 21) | u.i;
        }
        else if (((frac >> 1) & 1)== 1){
            frac = frac ^ 0b010;
            exp = -8 + 127;
            u.i = (frac << 22) | u.i;
        }
        else if ((frac & 1) == 1){
            frac = frac ^ 0b001;
            exp = -9 + 127;
            u.i = (frac << 23) | u.i;
        }
        u.i = (exp << 23) | u.i;
        return u.f;
    }
    else {
        exp += -7 + 127;
    }
//    normalized cases
    int frac = x & 0b00000111;
    u.i = exp << 23 | u.i;
    u.i = frac << 20 | u.i;
    return u.f;
}
