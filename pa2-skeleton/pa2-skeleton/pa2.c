//---------------------------------------------------------
// 
// Project #2: TinyFP Arithmetic
//
// April 5, 2018
//
// Jin-Soo Kim (jinsoo.kim@snu.ac.kr)
// Systems Software Laboratory
// Dept. of Computer Science and engineering
// Seoul National University
//
//---------------------------------------------------------

#include "pa2.h"

tinyfp add(tinyfp tf1, tinyfp tf2){
    tinyfp NAN = 0b01111001;
//	NAN case
    if (((tf1 & 0x78) == 0x78) && ((tf1 & 0x07)!=0))
        return NAN;

    if (((tf2 & 0x78) == 0x78) && ((tf2 & 0x07)!=0))
        return NAN;

//	INF case
    if ((tf1 & 0x78) == 0x78){
        if ((tf2 & 0x78) == 0x78) {
            if (tf1 == tf2)
                return tf1;
            return NAN;
        }
        return tf1;
    }
    if ((tf2 & 0x78) == 0x78){
        return tf2;
    }


    int e1 = (tf1 & 0b01111000) >> 3;
    int e2 = (tf2 & 0b01111000) >> 3;
    int m1 = tf1 & 0b00000111;
    int m2 = tf2 & 0b00000111;

    m1 = (e1 == 0) ? m1 : m1 | 0b1000;
    m2 = (e2 == 0) ? m2 : m2 | 0b1000;

    if (e1 == 0 && m1 != 0)
        m1 = m1 << 1;

    if (e2 == 0 && m2 !=0)
        m2 = m2 << 1;


    tinyfp result = 0;
    int sign = 0;
    int frac;
    int e;
    int diff;

    if (e1 >= e2){
        m1 = (tf1 >> 7) ? -(m1 << (e1 - e2)) : (m1 << (e1 - e2));
        m2 = (tf2 >> 7) ? -m2 : m2;
        frac = m1 + m2;
        e = e1;
        diff = e1 - e2;
    }
    else{
        m1 = (tf1 >> 7) ? -m1 : m1;
        m2 = (tf2 >> 7) ? -(m2 << (e2 - e1)) : (m2 << (e2 - e1));
        frac = m1 + m2;
        e = e2;
        diff = e2 - e1;
    }

    if (frac < 0){
        sign = 1;
        frac *= -1;
    }

    if (!frac)
        return 0;
    while((frac >> (diff + 3)) > 1 ){
        diff ++;
        e ++;
    }
    while(!(frac >> (diff + 3))){
        diff --;
        e --;
    }

//  round
    int round = 0;
    if ((diff + 4) > 4){
        int g = (frac >> ((diff + 4) - 4)) & 1;
        int r = (frac >> ((diff + 4) - 5)) & 1;
        int s = 0;
        if ((diff + 4) > 5)
            s = (frac % (2 << ((diff + 4)-6))) > 0;
        if ((g==1 && r==1) || (r ==1 && s==1)){
            round = 1;
        }
        frac = (frac >> ((diff + 4) - 4)) + round;
    }
    else{
        frac = frac << (4 - (diff + 4));
    }
    if (frac==0b10000){
        frac = 0b1000;
        e += 1;
    }
    if (e > 0b1110) {
        result = 0b1111000;
        result +=  sign<<7;
        return result;
    }

    if (e <= 0){
        frac = frac >> (-e + 1);
        e = 0;
    }

    frac = frac & 0b111;

    result = (sign << 7) + (e << 3) + frac;
    return result;
}

tinyfp mul(tinyfp tf1, tinyfp tf2){
    tinyfp NAN = 0b01111001;
//  NAN case
    if (((tf1 & 0x78) == 0x78) && ((tf1 & 0x07)!=0))
        return NAN;

    if (((tf2 & 0x78) == 0x78) && ((tf2 & 0x07)!=0))
        return NAN;

//  INF case
    int sign = (tf1 >> 7) ^ (tf2 >> 7);
    if ((tf1 & 0x78) == 0x78){
        if(!(tf2 & 0x7F))
            return NAN;
        return 0b01111000 | (sign << 7);
    }

    if ((tf2 & 0x78) == 0x78){
        if (!(tf1 & 0x7F))
            return NAN;
        return 0b01111000 | (sign << 7);
    }

    tinyfp result = 0;
    int e1 = (tf1 & 0b01111000) >> 3;
    int e2 = (tf2 & 0b01111000) >> 3;
    int m1 = tf1 & 0b00000111;
    int m2 = tf2 & 0b00000111;
    m1 = (e1 == 0) ? m1 : m1 | 0b1000;
    m2 = (e2 == 0) ? m2 : m2 | 0b1000;

    if (m1 == 0 || m2 == 0)
        return 0;

    if (!e1){
        while(((m1 >> 3) & 1) != 1){
            e1 -= 1;
            m1 = m1 << 1;
        }
        e1++;
    }
    if (!e2){
        while(((m2 >> 3) & 1) != 1){
            e2 -= 1;
            m2 = m2 << 1;
        }
        e2++;
    }

    int e = e1 + e2 - 7;
    unsigned int frac = m1 * m2;

    int s = 0;
    if((frac >> 6) > 1){
        s = (frac & 1);
        frac = frac >> 1;
        e ++;
    }

    if (e > 0b1110) {
        result = 0b1111000;
        result +=  sign<<7;
        return result;
    }

    int round = 0;
    int g = 0, r = 0;

    if (e > 0){
        g = (frac >> 3) & 1;
        r = (frac >> 2) & 1;
        s |= ((frac & 0b11) != 0);
        round = (r == 1 && !(g == 0 && s == 0));
        frac = (frac >> 3) + round;
        if (frac & 0b10000){
            frac = frac >> 1;
            e++;
        }
    }
    else if(e >= -3) {

        g = (frac >> (3 - e + 1)) & 1;
        r = (frac >> (2 - e + 1)) & 1;
        s |= ((frac %(1 << (2 - e + 1))) != 0);
        round = (r == 1 && !(g == 0 && s == 0));
        frac = frac >> (-e + 1);
        frac = (frac >> 3) + round;
        e = 0;
        if (frac & 0b1000)
            e++;
    }
    else{
        return 0;
    }


    frac = frac & 0b111;
    result = (sign << 7) + (e << 3) + frac;
    return result;
}

int gt(tinyfp tf1, tinyfp tf2){
    tinyfp NAN = 0b01111001;

    //  NAN case
    if (((tf1 & 0x78) == 0x78) && ((tf1 & 0x07)!=0))
        return 0;

    if (((tf2 & 0x78) == 0x78) && ((tf2 & 0x07)!=0))
        return 0;

    if ((tf1 & 0x7F) == 0 && ((tf2 & 0x7F) == 0))
        return 0;

    if (tf1 == 0b01111000){
        if (tf1 == tf2)
            return 0;
        return 1;
    }
    if (tf1 == 0b11111000)
        return 0;
    if ((tf2 << 1) == 0b11110000){
        if ((tf2 >> 7) == 1)
            return 1;
        else
            return 0;
    }

    int s1 = tf1 >> 7;
    int s2 = tf2 >> 7;

    if (s1 != s2)
        return s2;
    int e1 = (tf1 & 0b01111000) >> 3;
    int e2 = (tf2 & 0b01111000) >> 3;
    if (e1 != e2){
        if (!s1)
            return e1>e2;
        else
            return e1<e2;
    }
    int m1 = tf1 & 0b00000111;
    int m2 = tf2 & 0b00000111;
    if (m1 != m2) {
        if (!s1)
            return m1 > m2;
        else
            return m1 < m2;
    }
    return 0;
}

int eq(tinyfp tf1, tinyfp tf2){
    if (((tf1 & 0x7F) == 0) && ((tf2 & 0x7F) == 0))
        return 1;

    if (((tf1 & 0x78) == 0x78) && ((tf1 & 0x07)!=0))
        return 0;

    if (((tf2 & 0x78) == 0x78) && ((tf2 & 0x07)!=0))
        return 0;
    return tf1 == tf2;
}
