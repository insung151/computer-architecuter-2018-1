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


#include <stdio.h>
#include "pa1.h"

#define BYTE_FORMAT "%c%c%c%c%c%c%c%c"
#define BYTE_TO_BITS(byte)  (byte & 0x80 ? '1' : '0'), \
  							(byte & 0x40 ? '1' : '0'), \
  							(byte & 0x20 ? '1' : '0'), \
  							(byte & 0x10 ? '1' : '0'), \
  							(byte & 0x08 ? '1' : '0'), \
  							(byte & 0x04 ? '1' : '0'), \
  							(byte & 0x02 ? '1' : '0'), \
  							(byte & 0x01 ? '1' : '0') 

#define PRINT_WORD(s,i)		printf(s"("BYTE_FORMAT" ", BYTE_TO_BITS((i) >> 24));	\
							printf(BYTE_FORMAT" ", BYTE_TO_BITS((i) >> 16)); 		\
							printf(BYTE_FORMAT" ", BYTE_TO_BITS((i) >> 8)); 		\
							printf(BYTE_FORMAT") => ", BYTE_TO_BITS(i));
#define PRINT_INT(i)		PRINT_WORD("int", i)
#define PRINT_FLOAT(i)		PRINT_WORD("float", i)
#define PRINT_TINYFP(t)		printf("tinyfp("BYTE_FORMAT"), ", BYTE_TO_BITS(t));

#define TINYFP_INF_NAN(t)	((((t) >> 3) & 0x0f) == 0x0f)
#define FLOAT_INF_NAN(f)	((((f) >> 23) & 0xff) == 0xff)
#define TEST_INF_NAN(f,t)	(TINYFP_INF_NAN(t) && FLOAT_INF_NAN(f) && 				\
							((((t) >> 7) == (f) >> 31) && 							\
							(((((t) & 0x07) == 0) && (((f) & 0x007fffff) == 0)) || 	\
							((((t) & 0x07) > 0) && (((f) & 0x007fffff) > 0)))))

#define CHECK_VALUE(r,a)	printf("%s\n", ((r) == (a))? "CORRECT" : "WRONG")
#define CHECK_INF_NAN(f,t)	printf("%s\n", TEST_INF_NAN(f,t)? "CORRECT" : "WRONG")

#define N 	6

int int_literal[N] = {200, -198, 240, 27, 18, -19};
tinyfp int2tinyfpAnswer[N] = {0b01110100, 0b11110100, 0b01110111, 0b01011101, 0b01011001,0b11011001};

tinyfp tinyfp_literal[N] = {0b01110100, 0b11110100, 0b01110111, 0b01011101, 0b01011001,0b11011001 };
int tinyfp2intAnswer[N] = {192, -192, 240, 26, 18, -18};

float float_literal[N] = { 11.312499, 0.088379, -0.003235, -0.006469, -0.000809, 0.0719};
tinyfp float2tinyfpAnswer[N] = {0b01010011, 0b00011011, 0b10000001, 0b10000011, 0b10000000, 0b00011001};

tinyfp tinyfp_literal2[N] = {0b00000010, 0b00010000, 0b11101010, 0b10000000, 0b00000111, 0b00000001};
float tinyfp2floatAnswer[N] = {0.00390625, 0.03125, -80.0, -0.0, 0.013671875, 0.001953125};

int main(void){
	int idx;
	tinyfp tf;
	int i;
	union _union{
		unsigned int i;
		float f;
	} u;

	printf("\nTest 1: casting from int to tinyfp\n");
	for(idx = 0;idx < N; idx++){
		i = int_literal[idx];
		tf = int2tinyfp(i);
		PRINT_INT(i);
		PRINT_TINYFP(tf);
		CHECK_VALUE(tf, int2tinyfpAnswer[idx]);
	}

	printf("\nTest 2: casting from tinyfp to int\n");
	for(idx = 0;idx < N; idx++){
		tf = tinyfp_literal[idx];
		i = tinyfp2int(tf);
		PRINT_TINYFP(tf);
		PRINT_INT(i);
		CHECK_VALUE(i, tinyfp2intAnswer[idx]);
	}

	printf("\nTest 3: casting from float to tinyfp\n");
	for(idx = 0;idx < N; idx++){
		u.f = float_literal[idx];
		tf = float2tinyfp(u.f);
		PRINT_FLOAT(u.i);
		PRINT_TINYFP(tf);
		FLOAT_INF_NAN(u.i)? CHECK_INF_NAN(u.i, tf) : CHECK_VALUE(tf, float2tinyfpAnswer[idx]);
	}

	printf("\nTest 4: casting from tinyfp to float\n");
	for(idx = 0;idx < N; idx++){
		tf = tinyfp_literal2[idx];
		u.f = tinyfp2float(tf);
		PRINT_TINYFP(tf);
		PRINT_FLOAT(u.i);
		TINYFP_INF_NAN(tf)? CHECK_INF_NAN(u.i, tf) : CHECK_VALUE(u.f, tinyfp2floatAnswer[idx]);
	}

	return 0;
}
