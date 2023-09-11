
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract BitwiseOps {
    // Function to perform bitwise AND operation
    function and(uint x, uint y) external pure returns (uint) {
        // x     = 1110 = 8 + 4 + 2 + 0 = 14
        // y     = 1011 = 8 + 0 + 2 + 1 = 11
        // x & y = 1010 = 8 + 0 + 2 + 0 = 10
        return x & y;
    }

    // Function to perform bitwise OR operation
    function or(uint x, uint y) external pure returns (uint) {
        // x     = 1100 = 8 + 4 + 0 + 0 = 12
        // y     = 1001 = 8 + 0 + 0 + 1 = 9
        // x | y = 1101 = 8 + 4 + 0 + 1 = 13
        return x | y;
    }

    // Function to perform bitwise XOR operation
    function xor(uint x, uint y) external pure returns (uint) {
        // x     = 1100 = 8 + 4 + 0 + 0 = 12
        // y     = 0101 = 0 + 4 + 0 + 1 = 5
        // x ^ y = 1001 = 8 + 0 + 0 + 1 = 9
        return x ^ y;
    }

    // Function to perform bitwise NOT operation
    function not(uint8 x) external pure returns (uint8) {
        // x  = 00001100 =   0 +  0 +  0 +  0 + 8 + 4 + 0 + 0 = 12
        // ~x = 11110011 = 128 + 64 + 32 + 16 + 0 + 0 + 2 + 1 = 243
        return ~x;
    }

    // Function to perform bitwise left shift
    function shiftLeft(uint x, uint bits) external pure returns (uint) {
        // 1 << 0 = 0001 --> 0001 = 1
        // 1 << 1 = 0001 --> 0010 = 2
        // 1 << 2 = 0001 --> 0100 = 4
        // 1 << 3 = 0001 --> 1000 = 8
        // 3 << 2 = 0011 --> 1100 = 12
        return x << bits;
    }

    // Function to perform bitwise right shift
    function shiftRight(uint x, uint bits) external pure returns (uint) {
        // 8  >> 0 = 1000 --> 1000 = 8
        // 8  >> 1 = 1000 --> 0100 = 4
        // 8  >> 2 = 1000 --> 0010 = 2
        // 8  >> 3 = 1000 --> 0001 = 1
        // 8  >> 4 = 1000 --> 0000 = 0
        // 12 >> 1 = 1100 --> 0110 = 6
        return x >> bits;
    }

    // Function to get the last n bits from x
    function getLastNBits(uint x, uint n) external pure returns (uint) {
        // Example, last 3 bits:
        // x        = 1101 = 13
        // mask     = 0111 = 7
        // x & mask = 0101 = 5
        uint mask = (1 << n) - 1;
        return x & mask;
    }

    // Function to get the last n bits from x using the mod operator
    function getLastNBitsUsingMod(uint x, uint n) external pure returns (uint) {
        // 1 << n = 2 ** n
        return x % (1 << n);
    }
}
/*
Here's an explanation of each function and its corresponding comment:

1. `and(uint x, uint y)`: Performs a bitwise AND operation between two integers `x` and `y`. The comment explains the operation and provides an example.

2. `or(uint x, uint y)`: Performs a bitwise OR operation between two integers `x` and `y`. The comment explains the operation and provides an example.

3. `xor(uint x, uint y)`: Performs a bitwise XOR operation between two integers `x` and `y`. The comment explains the operation and provides an example.

4. `not(uint8 x)`: Performs a bitwise NOT operation on an 8-bit integer `x`. The comment shows the binary representation before and after the operation.

5. `shiftLeft(uint x, uint bits)`: Performs a left shift operation on the integer `x` by the specified number of `bits`. The comment provides examples of left shifts.

6. `shiftRight(uint x, uint bits)`: Performs a right shift operation on the integer `x` by the specified number of `bits`. The comment provides examples of right shifts.

7

. `getLastNBits(uint x, uint n)`: Extracts the last `n` bits from the integer `x` using a bit mask. The comment explains the mask creation and provides an example.

8. `getLastNBitsUsingMod(uint x, uint n)`: Extracts the last `n` bits from the integer `x` using the modulo operator. The comment provides an alternative method to achieve the same result.

These functions demonstrate various bitwise operations and bit manipulation techniques in Solidity.
*/