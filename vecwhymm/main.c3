import std::io;

// Flag: UMASS{i<3s1md!h4v_u_h34rd_0f_z3nb133d?}

/*
const YMMPackedUL FLAG_XOR_BYTES ={ // flag is xor with these bytes
    0xe9d1320babe13369, 
    0x555b51ee3c59eb14,
    0xd0f949de8bcd6dbe,
    0x993997d56c58653e
};
*/

const YMMPackedUL FLAG_XOR_HINT_LOWER = {
    0xe9d1320000000000,
    0x555b51e000000000,
    0xd0f949d000000000,
    0x9939970000000000
};

const YMMPackedUL FLAG_XOR_HINT_UPPER = {
    0xe9d1330000000000,
    0x555b520000000000,
    0xd0f9500000000000,
    0x9939980000000000
};

const YMMPackedUL XORD_FLAG = {
    0xc8b55f3ad8d20f00,
    0x66330e9b632fdf7c,
    0xaaa62feed4a91f8a,
    0xa65da4e65d3a0b0d,
};

const YMMPackedUL KEY_HINT_LOWER = {
    0xAc15c0D060000000,
    0xB105c0de00000000,
    0xb0a710d0f0000000,
    0x1abeaba000000fac
};

const YMMPackedUL KEY_HINT_UPPER = {
    0xAc15c0D06FFFFFFF,
    0xB105c0deffffffff,
    0xb0a710d0ffffffff,
    0x1abeafffffffffac
};

fn bool inRange(ulong x, ulong low, ulong high) @noinline {
    return (low < x && x < high);
}

fn bool checkSolution(YMMPackedUL inp) @noinline @callconv("veccall") {
    if (inRange(inp[0], FLAG_XOR_HINT_LOWER[0], FLAG_XOR_HINT_UPPER[0])) {
        if (inRange(inp[1], FLAG_XOR_HINT_LOWER[1], FLAG_XOR_HINT_UPPER[1])) {
            if (inRange(inp[2], FLAG_XOR_HINT_LOWER[2], FLAG_XOR_HINT_UPPER[2])) {
                if (inRange(inp[3], FLAG_XOR_HINT_LOWER[3], FLAG_XOR_HINT_UPPER[3])) {
                    return true;
                } else {
                    write_syscall(1, "Incorrect at solution 4!\n", 26);
                    exit_syscall(1);
                }
            } else {
                write_syscall(1, "Incorrect at solution 3!\n", 26);
                exit_syscall(1);
            }
            
        } else {
            write_syscall(1, "Incorrect at solution 2!\n", 26);
            exit_syscall(1);
        }
    } else {
        write_syscall(1, "Incorrect at solution 1!\n", 26);
        exit_syscall(1);
    }
    return false;
}

fn bool checkGuess(YMMPackedUL guess) @noinline @callconv("veccall") {
    if (inRange(guess[0], KEY_HINT_LOWER[0], KEY_HINT_UPPER[0])) {
        if (inRange(guess[1], KEY_HINT_LOWER[1], KEY_HINT_UPPER[1])) {
            if (inRange(guess[2], KEY_HINT_LOWER[2], KEY_HINT_UPPER[2])) {
                if (inRange(guess[3], KEY_HINT_LOWER[3], KEY_HINT_UPPER[3])) {
                    return true;
                } else {
                    write_syscall(1, "Incorrect at guess 4!\n", 23);
                    exit_syscall(1);
                }
            } else {
                write_syscall(1, "Incorrect at guess 3!\n", 23);
                exit_syscall(1);
            }
            
        } else {
            write_syscall(1, "Incorrect at guess 2!\n", 23);
            exit_syscall(1);
        }
    } else {
        write_syscall(1, "Incorrect at guess 1!\n", 23);
        exit_syscall(1);
    }
    return false;
}

/*
const char[<32>] M_VAL_FMA = { // SIMD IN Bytes form
    0x53, 0x69, 0x6e, 0x67, 
    0x6c, 0x65, 0x20, 0x49, 
    0x6e, 0x73, 0x74, 0x72, 
    0x75, 0x63, 0x74, 0x69, 
    0x6f, 0x6e, 0x20, 0x4d, 
    0x75, 0x6c, 0x74, 0x69, 
    0x70, 0x6c, 0x65, 0x20, 
    0x44, 0x61, 0x74, 0x06
};*/

const YMMPackedUL M_VAL_FMA_YMM = { // SIMD IN YMMPackedUL BE
    0x53696e676c652049,
    0x6e73747275637469,
    0x6f6e204d756c7469,
    0x706c652044617406,
};

const YMMPackedUL B_VAL_FMA_YMM = {
    0x4d756c7469706c65,
    0x2044617461205369,
    0x6e676c6520496e73,
    0x7472756374696f6e,
};

const ZString SIMD = "Single Instruction Multiple Data";
const YMMPackedUL SIMD_YMM = {
    0x4920656C676E6953, 
    0x697463757274736E,
    0x69746C754D206E6F,
    0x6174614420656C70,
};

const ZString SIMDR = "ataD elpitluM noitcurtsnI elgniS";
const YMMPackedUL SIMDR_YMM = {
    0x6174614420656C70,
    0x69746C754D206E6F,
    0x697463757274736E,
    0x4920656C676E6953
};

const ZString MDSI = "Multiple Data Single Instruction";

alias XMMStr = char[<16>];
alias YMMStr = char[<32>];
alias YMMStrDiff = ichar[<32>];

alias YMMPackedL = long[<4>];
alias YMMPackedUL = ulong[<4>];
alias YMPackedUI = uint[<8>];
alias XMMPackedUI = uint[<4>]; 

struct PackedXMML {
    long lower;
    long higher;
}

struct PackedXMMUL {
    ulong lower;
    ulong higher;
}

struct PackedXMMF {
    double lower;
    double higher;
}

struct PackedYMMUL {
    PackedXMMUL lower;
    PackedXMMUL higher;
    long pad;
}

struct PackedYMML {
    PackedXMML lower;
    PackedXMML higher;
    ulong pad;
}

extern fn void exit_syscall(int status) @inline;
extern fn int open_syscall(ZString path, uint flags, uint mode) @inline;
extern fn ulong read_syscall(uint fd, ZString buf, usz len) @inline;
extern fn ulong write_syscall(uint fd, ZString buf, usz len) @inline;

fn void main() {
    write_syscall(1,"What is cool?\n", 15);
    YMMPackedUL input1;
    ulong read = read_syscall(0, (ZString)&input1, 32);
    if (read == 0) {
        write_syscall(1, "No input provided!\n", 20);
        exit_syscall(1);
    }
    PackedXMMF res1 = ymmpulcmp(SIMD_YMM, input1);
    if (res1.higher != -1.0) {
        write_syscall(1, "Incorrect!\n", 12);
        write_syscall(1, "Incorrect Character Position: ", 30);
        std::io::printn(res1.higher);
        //std::io::printfn("Incorrect Character Difference: %f\n", res1.lower);
        exit_syscall(1);
    }
    write_syscall(1, "Correct!\n", 9);
    write_syscall(1, "Whats your guess?\n",19);
    YMMPackedUL inputX;
    read = read_syscall(0, (ZString)&inputX, 32);
    if (read == 0) {
        write_syscall(1, "No first guess provided!\n", 26);
        exit_syscall(1);
    }
    //YMMPackedUL solution = ymmprocess(M_VAL_FMA_YMM, B_VAL_FMA_YMM, inputX);
    checkGuess(inputX);
    YMMPackedUL solution = ymmHash(inputX);
    checkSolution(solution);
    YMMPackedUL ct = ymmpxor(solution, XORD_FLAG);
    write_syscall(1, "Result: ", 8);
    write_syscall(1, "UMASS{",6);
    write_syscall(1, (ZString)&ct, 32);
    write_syscall(1, "}\n", 2);
    write_syscall(1, "Local flag test (doesn't do much)\n", 35);
    int flagfd = open_syscall("flag.txt",0,0);
    if (flagfd != 0) {
        write_syscall(1, "Flag file not found!\n", 21);
    }
    char [<32>] flag;
    read = read_syscall((uint)flagfd, (ZString)&flag, 32);
    if (read == 0) {
        write_syscall(1, "No flag read!\n", 15);
        exit_syscall(1);
    }
    PackedXMML res = vstrncmp((ZString)&ct, (ZString)&flag, 32);
    if (res.lower != 0) {
        write_syscall(1, "Incorrect!\n", 12);
        io::printfn("Incorrect Character Position: %d\n", res.higher);
        io::printfn("Incorrect Character Difference: %d\n", res.lower);
        exit_syscall(1);
    }
    write_syscall(1, "Correct!", 8); 
}

fn YMMPackedUL ymmHash(YMMPackedUL i) @noinline @callconv("veccall") {
    const ulong HASH = 0xcbf29ce484222325;
    const ulong PRIME1 = 11400714785074694791UL;
    const ulong PRIME2 = 14029467366897019727UL;
    const ulong PRIME3 = 1609587929392839161UL;
    const ulong PRIME4 = 9650029242287828579UL;
    YMMPackedUL ret;
    ret = i ^ HASH;
    ret *= PRIME1;
    ret ^= ymmRotateULRight(ret, 33);
    ret *= PRIME2;
    ret ^= ymmRotateULRight(ret, 29);
    ret *= PRIME3;
    ret ^= ymmRotateULRight(ret, 31);
    ret *= PRIME4;
    ret ^= ymmRotateULRight(ret, 23);
    ret *= B_VAL_FMA_YMM;
    ret ^= ymmRotateULRight(ret, 37);
    ret *= M_VAL_FMA_YMM;
    ret ^= ymmRotateULRight(ret, 41);
    return ret;

}

fn ulong lrotate(ulong value, int shift) {
    return (value << shift) | (value >> (64 - shift));
}

fn ulong rrotate(ulong value, int shift) {
    return (value >> shift) | (value << (64 - shift));
}

fn YMMPackedUL ymmRotateULeft(YMMPackedUL a, int shift)  @noinline @callconv("veccall") {
    YMMPackedUL ret;
    ret[0] = lrotate(a[0], shift);
    ret[1] = lrotate(a[1], shift);
    ret[2] = lrotate(a[2], shift);
    ret[3] = lrotate(a[3], shift);
    return ret;
}

fn YMMPackedUL ymmRotateULRight(YMMPackedUL a, int shift) @noinline @callconv("veccall") {
    YMMPackedUL ret;
    ret[0] = rrotate(a[0], shift);
    ret[1] = rrotate(a[1], shift);
    ret[2] = rrotate(a[2], shift);
    ret[3] = rrotate(a[3], shift);
    return ret;
}

fn YMMPackedL ymmpxor(YMMPackedL a, YMMPackedL b) {
    return a ^ b;
}

fn YMMStrDiff vConvPLtoYMMStrDiff(YMMPackedL a) @inline {
    YMMStrDiff ret;
    ret[0] = (ichar)(a[0] & 0xFF);
    ret[1] = (ichar)((a[0] >> 8) & 0xFF);
    ret[2] = (ichar)((a[0] >> 16) & 0xFF);
    ret[3] = (ichar)((a[0] >> 24) & 0xFF);
    ret[4] = (ichar)((a[0] >>32) & 0xFF);
    ret[5] = (ichar)((a[0] >> 40) & 0xFF);
    ret[6] = (ichar)((a[0] >> 48) & 0xFF);
    ret[7] = (ichar)((a[0] >> 56) & 0xFF);
    ret[8] = (ichar)(a[1] & 0xFF);
    ret[9] = (ichar)((a[1] >> 8) & 0xFF);
    ret[10] = (ichar)((a[1] >> 16) & 0xFF);
    ret[11] = (ichar)((a[1] >> 24) & 0xFF);
    ret[12] = (ichar)((a[1] >>32) & 0xFF);
    ret[13] = (ichar)((a[1] >> 40) & 0xFF);
    ret[14] = (ichar)((a[1] >> 48) & 0xFF);
    ret[15] = (ichar)((a[1] >> 56) & 0xFF);
    ret[16] = (ichar)(a[2] & 0xFF);
    ret[17] = (ichar)((a[2] >> 8) & 0xFF);
    ret[18] = (ichar)((a[2] >> 16) & 0xFF);
    ret[19] = (ichar)((a[2] >> 24) & 0xFF);
    ret[20] = (ichar)((a[2] >>32) & 0xFF);
    ret[21] = (ichar)((a[2] >> 40) & 0xFF);
    ret[22] = (ichar)((a[2] >> 48) & 0xFF);
    ret[23] = (ichar)((a[2] >> 56) & 0xFF);
    ret[24] = (ichar)(a[3] & 0xFF);
    ret[25] = (ichar)((a[3] >> 8) & 0xFF);
    ret[26] = (ichar)((a[3] >> 16) & 0xFF);
    ret[27] = (ichar)((a[3] >> 24) & 0xFF);
    ret[28] = (ichar)((a[3] >>32) & 0xFF);
    ret[29] = (ichar)((a[3] >> 40) & 0xFF);
    ret[30] = (ichar)((a[3] >> 48) & 0xFF);
    ret[31] = (ichar)((a[3] >> 56) & 0xFF);

    return ret;
}

fn YMMStr vpxorBytes32(YMMStr a, YMMStr b) @inline {
    return a^b;
}

fn void char32ToZString(char[<32>] in, ZString *out) @inline {
    (*out)[0] = in[0];
    (*out)[1] = in[1];
    (*out)[2] = in[2];
    (*out)[3] = in[3];
    (*out)[4] = in[4];
    (*out)[5] = in[5];
    (*out)[6] = in[6];
    (*out)[7] = in[7];
    (*out)[8] = in[8];
    (*out)[9] = in[9];
    (*out)[10] = in[10];
    (*out)[11] = in[11];
    (*out)[12] = in[12];
    (*out)[13] = in[13];
    (*out)[14] = in[14];
    (*out)[15] = in[15];
    (*out)[16] = in[16];
    (*out)[17] = in[17];
    (*out)[18] = in[18];
    (*out)[19] = in[19];
    (*out)[20] = in[20];
    (*out)[21] = in[21];
    (*out)[22] = in[22];
    (*out)[23] = in[23];
    (*out)[24] = in[24];
    (*out)[25] = in[25];
    (*out)[26] = in[26];
    (*out)[27] = in[27];
    (*out)[28] = in[28];
    (*out)[29] = in[29];
    (*out)[30] = in[30];
    (*out)[31] = in[31];
}

fn ichar[<16>] char16sub(char[<16>] a, char[<16>] b) @inline {
    return b - a;
}

fn bool charInRange(char c, char low, char high) @inline {
    return (low < c && c < high);
}

fn PackedXMML char16cmp(char[<16>] a, char[<16>] b) @inline @callconv("veccall") {
    // Return the index of where the first different character is in the 16 byte vec in int128
    long ret = -1;
    for (int i =0;i<16;i++) {
            if (!(charInRange(a[i], 47, 61) ||
            charInRange(a[i], 94, 123) || 
            (a[i] == 33))) {
                write_syscall(1, "Out of range character in input!\n", 34);
            }
        }
    PackedXMML retval;
    ichar[<16>] sub = char16sub(a, b);
    if (sub != (ichar[<16>])0) { // if the two strings are equal, return 0
            while (ret < 16) {
                if (sub[++ret] != 0x0) {
                    retval.higher = ret; 
                    retval.lower = (long)sub[ret];
                }
            }
        }
    return retval;
}

fn int[<4>] int4cmp(int[<4>] a, int[<4>] b) @inline {
    return b - a;
}

fn PackedXMMF ymmpulcmp(YMMPackedUL a, YMMPackedUL b) @noinline @callconv("veccall") {
    PackedXMMF retval;
    YMMPackedUL sub = b - a;
    if (sub != (YMMPackedUL)0) {
        YMMStrDiff diffStr = vConvPLtoYMMStrDiff(sub);
        for (uint i = 0; i < 32; i++) {
            if (diffStr[i] != 0x0) {
                retval.higher = (double)i;
                retval.lower = (double)(long)diffStr[i];
                return retval;
            }
        }
    }
    retval.higher = -1.0;
    retval.lower = 0.0;
    return retval;
}

fn PackedXMML vstrncmp(ZString a, ZString b, usz len) @inline @callconv("veccall") {
    // returns positon in higher, diff in lower
    if ((len % 16) != 0) {
        write_syscall(1, "Length must be a multiple of 16\n", 30);
    }
    usz idx = 0;
    PackedXMML retval;

    while (1) {
        char[<16>] packedA; // optimized into PINSRB
        packedA[0] = a[idx];
        packedA[1] = a[idx + 1];
        packedA[2] = a[idx + 2];
        packedA[3] = a[idx + 3];
        packedA[4] = a[idx + 4];
        packedA[5] = a[idx + 5];
        packedA[6] = a[idx + 6];
        packedA[7] = a[idx + 7];
        packedA[8] = a[idx + 8];
        packedA[9] = a[idx + 9];
        packedA[10] = a[idx + 10];
        packedA[11] = a[idx + 11];
        packedA[12] = a[idx + 12];
        packedA[13] = a[idx + 13];
        packedA[14] = a[idx + 14];
        packedA[15] = a[idx + 15];
        

        char[<16>] packedB;
        packedB[0] = b[idx];
        packedB[1] = b[idx + 1];
        packedB[2] = b[idx + 2];
        packedB[3] = b[idx + 3];
        packedB[4] = b[idx + 4];
        packedB[5] = b[idx + 5];
        packedB[6] = b[idx + 6];
        packedB[7] = b[idx + 7];
        packedB[8] = b[idx + 8];
        packedB[9] = b[idx + 9];
        packedB[10] = b[idx + 10];
        packedB[11] = b[idx + 11];
        packedB[12] = b[idx + 12];
        packedB[13] = b[idx + 13];
        packedB[14] = b[idx + 14];
        packedB[15] = b[idx + 15];
        PackedXMML res = char16cmp(packedA, packedB);
        if (res.higher != -1) { // if the two strings are not equal
            retval.higher = res.higher * idx; 
            retval.lower = res.lower; // must be not 0
            return retval;
        }
        idx += 16;
        if (idx >= len ) {
            break;
        }
    }
        return retval;
    }