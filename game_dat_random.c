#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>

#define RAND(a) ((a)*0x343fd+0x269ec3)
#define KC0 3000
#define KC1 20000
#define KC2 200

// static random table generate proc:
// (Little Endian, x86)
// getNextRandom() {
//     _seed = RAND(_seed)  // _seed*0x343fd+0x269ec3 
//     return ((_seed >> 16) & 0x7fff)
// }
// generate() {
//     r1 = getNextRandom()   
//     K1 = r1 % KC0
//     writeU32(K1 + _offset + KC1)
//     _offset += 4
//     r2 = getNextRandom()   
//     K2 = r2 % KC0
//     writeU32(K2 + _offset + KC2 + K1)
//     _offset += 4
//     while (_offset < _len) {
//         r = getNextRandom()
//         writeU8(r >> 8)
//         _offset ++
//     }
// }
//

int main(int argc, const char** argv) {
    if (argc < 10) {
        printf("Usage: %s <offset> <data..(at least 8 bytes)>\n", argv[0]);
        return 0;
    }
    uint32_t offset = strtol(argv[1], NULL, 16);
    uint8_t raw[1000];
    for (int i = 0; i < 1000 && i < argc - 2; i ++) {
        raw[i] = strtol(argv[i + 2], NULL, 16);
    }
    uint8_t* data = raw + 8;
    uint32_t datalen = argc - 10;

    uint32_t K1 = (raw[0] | (raw[1] << 8) | (raw[2] << 16) | (raw[3] << 24));
    uint16_t r1 = K1 - KC1 - offset;
    uint32_t K2 = (raw[4] | (raw[5] << 8) | (raw[6] << 16) | (raw[7] << 24));
    uint16_t r2 = K2 - K1 - KC2 - offset - 4;
    uint16_t r1s[100];
    uint16_t r2s[100];
    uint16_t r1sl = 0;
    uint16_t r2sl = 0;
    uint32_t possible[1000];
    uint16_t possiblec = 0;
    uint32_t result[1000];
    uint16_t resultc = 0;

    uint16_t v = 0;
    for (int i = 0;; i ++) {
        v = r1 + i * KC0;
        if (v > 0x7fff) break;
        r1s[i * 2] = v;
        r1s[i * 2 + 1] = v | 0x8000;
        r1sl = i * 2 + 2;
    }
    for (int i = 0;; i ++) {
        v = r2 + i * KC0;
        if (v > 0x7fff) break;
        r2s[i * 2] = v;
        r2s[i * 2 + 1] = v | 0x8000;
        r2sl = i * 2 + 2;
    }
    for (int i = 0; i < r1sl; i ++) {
        uint16_t c = r1s[i];
        uint32_t base = c << 16;
        for (int j = 0; j <= 0xffff; j ++) {
            uint32_t v = base | j;
            uint32_t re = RAND(v);
            uint16_t reh = re >> 16;
            for (int k = 0; k < r2sl; k ++) {
                if (reh == r2s[k]) {
                    possible[possiblec ++] = re;
                }
            }
        }
    }
    for (int i = 0; i < possiblec; i ++) {
        uint32_t cur = possible[i];
        int j = 0;
        for (j = 0; j < datalen; j ++) {
            cur = RAND(cur);
            if (((cur >> 24) & 0x7f) != data[j]) {
                break;
            }
        }
        if (j == datalen) {
            result[resultc ++] = possible[i];
        }
    }
    for (int i = 0; i < resultc; i ++) {
        printf("possible seed: %08x\n", result[i]);
    }
    if (resultc <= 0) {
        return -1;
    }
    printf("\npredict:\n");
    uint32_t cur = result[0];
    for (int i = 0; i < 100; i ++) {
        cur = RAND(cur);
        printf("%02x ", ((cur >> 24) & 0x7f));
    }
    printf("\n");
    return 0;
}
