#include <stdio.h>
#include <string.h>
#include <time.h>

const char flag[] = "i<3s1md!h4v_u_h34rd_0f_z3nb133d?";
unsigned long lrotate(unsigned long value, int shift) {
    return (value << shift) | (value >> (64 - shift));
}

unsigned long rrotate(unsigned long value, int shift) {
    return (value >> shift) | (value << (64 - shift));
}

const unsigned long M_VAL_FMA_YMM[] = {
    // SIMD IN YMMPackedUL BE
    0x53696e676c652049,
    0x6e73747275637469,
    0x6f6e204d756c7469,
    0x706c652044617406,
};

const unsigned long B_VAL_FMA_YMM[] = {
    0x4d756c7469706c65,
    0x2044617461205369,
    0x6e676c6520496e73,
    0x7472756374696f6e,
};

unsigned long ymmHash(unsigned long i,char idx) {
    unsigned long hash = 0xcbf29ce484222325;
    const unsigned long PRIME1 = 11400714785074694791UL;
    const unsigned long PRIME2 = 14029467366897019727UL;
    const unsigned long PRIME3 = 1609587929392839161UL;
    const unsigned long PRIME4 = 9650029242287828579UL;

    hash = i ^ hash;
    hash *= PRIME1;
    hash ^= rrotate(hash, 33);
    hash *= PRIME2;
    hash ^= rrotate(hash, 29);
    hash *= PRIME3;
    hash ^= rrotate(hash, 31);
    hash *= PRIME4;
    hash ^= rrotate(hash, 23);
    hash *= B_VAL_FMA_YMM[idx];
    hash ^= rrotate(hash, 37);
    hash *= M_VAL_FMA_YMM[idx];
    hash ^= rrotate(hash, 41);
    return hash;
}

int main() {
    unsigned long inputs[] = {
        0xAc15c0D068badD11,
        0xB105c0deca11ab1e,
        0xb0a710d0f0ddc0de,
        0x1abeabad00beefac,
    };

    unsigned long hashs[4] = { 0 };

    for (int i = 0; i < 4; i++) {
        hashs[i] = ymmHash(inputs[i],i);
    }
    for (int i = 0; i < 4; i++) {
        printf("Hash %d: %lx\n", i, hashs[i]);
    }

    time_t now = time(NULL);
    unsigned long result = 0;
    int collision = 0;
    for (unsigned long i = 0xAc15c0D060000000; i <= 0xAc15c0D06FFFFFFF; i++) { // 0xAc15c0D068badD11U;i++) {
        result = ymmHash(i,0);
        if (result == hashs[0]) {
            collision++;
            //break;
        }
    }
    printf("Collision: %d\n", collision);
    printf("Time: %lu\n", time(NULL) - now);
    collision = 0;
    now = time(NULL);
    for (unsigned long i = 0xB105c0de00000000U; i <= 0xB105c0deffffffffU; i++) {
        result = ymmHash(i,1);
        if (result == hashs[1]) {
            collision++;
            //break;
        }
    }
    printf("Collision: %d\n", collision);
    printf("Time: %lu\n", time(NULL) - now);
    collision = 0;
    now = time(NULL);
    for (unsigned long i = 0xb0a710d0f0000000U; i <= 0xb0a710d0ffffffffU; i++) {
        result = ymmHash(i,2);
        if (result == hashs[2]) {
            collision++;
            //break;
        }
    }
    printf("Collision: %d\n", collision);
    printf("Time: %lu\n", time(NULL) - now);
    collision = 0;
    now = time(NULL);
    for (unsigned long i = 0x1abeaba000000facU; i <= 0x1abeabafffffffacU; i++) {
        result = ymmHash(i,3);
        if (result == hashs[3]) {
            collision++;
            //break;
        }
    }
    printf("Collision: %d\n", collision);
    printf("Time: %lu\n", time(NULL) - now);

    unsigned long results[4] = { 0 };
    unsigned long xorFlagLong[4] = { 0 };
    unsigned char xorFlag[33] = { 0x0 };
    memcpy(xorFlag, flag, sizeof(flag));
    memcpy(xorFlagLong, flag, 32);
    for (int i = 0; i < 4; i++) {
        xorFlagLong[i] ^= hashs[i];
    }
    for (int i = 0; i < 4; i++) {
        printf("XOR Flag Long %d: %lx\n", i, xorFlagLong[i]);
    }
    xorFlag[0] ^= (unsigned char)((results[0] >> 56) & 0xFF);
    xorFlag[1] ^= (unsigned char)((results[0] >> 48) & 0xFF);
    xorFlag[2] ^= (unsigned char)((results[0] >> 40) & 0xFF);
    xorFlag[3] ^= (unsigned char)((results[0] >> 32) & 0xFF);
    xorFlag[4] ^= (unsigned char)((results[0] >> 24) & 0xFF);
    xorFlag[5] ^= (unsigned char)((results[0] >> 16) & 0xFF);
    xorFlag[6] ^= (unsigned char)((results[0] >> 8) & 0xFF);
    xorFlag[7] ^= (unsigned char)(results[0] & 0xFF);
    xorFlag[8] ^= (unsigned char)((results[1] >> 56) & 0xFF);
    xorFlag[9] ^= (unsigned char)((results[1] >> 48) & 0xFF);
    xorFlag[10] ^= (unsigned char)((results[1] >> 40) & 0xFF);
    xorFlag[11] ^= (unsigned char)((results[1] >> 32) & 0xFF);
    xorFlag[12] ^= (unsigned char)((results[1] >> 24) & 0xFF);
    xorFlag[13] ^= (unsigned char)((results[1] >> 16) & 0xFF);
    xorFlag[14] ^= (unsigned char)((results[1] >> 8) & 0xFF);
    xorFlag[15] ^= (unsigned char)(results[1] & 0xFF);
    xorFlag[16] ^= (unsigned char)((results[2] >> 56) & 0xFF);
    xorFlag[17] ^= (unsigned char)((results[2] >> 48) & 0xFF);
    xorFlag[18] ^= (unsigned char)((results[2] >> 40) & 0xFF);
    xorFlag[19] ^= (unsigned char)((results[2] >> 32) & 0xFF);
    xorFlag[20] ^= (unsigned char)((results[2] >> 24) & 0xFF);
    xorFlag[21] ^= (unsigned char)((results[2] >> 16) & 0xFF);
    xorFlag[22] ^= (unsigned char)((results[2] >> 8) & 0xFF);
    xorFlag[23] ^= (unsigned char)(results[2] & 0xFF);
    xorFlag[24] ^= (unsigned char)((results[3] >> 56) & 0xFF);
    xorFlag[25] ^= (unsigned char)((results[3] >> 48) & 0xFF);
    xorFlag[26] ^= (unsigned char)((results[3] >> 40) & 0xFF);
    xorFlag[27] ^= (unsigned char)((results[3] >> 32) & 0xFF);
    xorFlag[28] ^= (unsigned char)((results[3] >> 24) & 0xFF);
    xorFlag[29] ^= (unsigned char)((results[3] >> 16) & 0xFF);
    xorFlag[30] ^= (unsigned char)((results[3] >> 8) & 0xFF);
    xorFlag[31] ^= (unsigned char)(results[3] & 0xFF);
    printf("XOR Cleartext Flag: ");
    for (int i = 0; i < 32; i++) {
        printf("%02x", xorFlag[i]);
    }
    return 0;
}