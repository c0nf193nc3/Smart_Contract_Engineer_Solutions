// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract MostSignificantBit {
    // Function to find the position of the most significant bit set to 1 in an integer
    function findMostSignificantBit(uint x) external pure returns (uint8 r) {
        // Initialize the result variable r to 0
        for (uint8 i = 128; i >= 1; i /= 2) {
            // Check if x is greater than or equal to 2^i
            if (x >= 2 ** i) {
                // Right-shift x by i positions
                x >>= i;
                // Add the value of i to the result r
                r += i;
            }
        }
        // Return the position of the most significant bit set to 1 in x
        return r;
    }
}

/*
Here's an explanation of the code:

1. The contract begins with SPDX license information and specifies the Solidity version.

2. The contract is named `MostSignificantBit` and contains a single function, `findMostSignificantBit`, which finds the position of the most significant bit set to 1 in an integer.

3. Inside the `findMostSignificantBit` function:
   - It initializes a result variable `r` to 0, which will be used to store the position of the most significant bit.
   - It enters a `for` loop with a loop variable `i` initialized to 128 (assuming 8-bit integers). The loop iterates while `i` is greater than or equal to 1, and in each iteration, `i` is divided by 2, effectively shifting to lower bit positions.
   - Inside the loop, it checks if `x` is greater than or equal to `2^i`, where `2^i` represents a power of 2. If this condition is met, it means that the most significant bit at position `i` is set to 1 in `x`.
   - If the condition is true, it right-shifts `x` by `i` positions to remove the higher bits, effectively shifting the next most significant bit to the rightmost position.
   - It adds the value of `i` to the result `r` to keep track of the position of the most significant bit.
   - The loop continues to check lower bit positions until it reaches the least significant bit.
   
4. After the loop completes, the function returns the value of `r`, which represents the position of the most significant bit set to 1 in the input integer `x`.

This contract is useful for determining the position of the leftmost (most significant) set bit in an integer, which can be helpful in various applications such as binary encoding and decoding.
*/