// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract UncheckedMath {
    // Function to add two numbers without overflow checking
    function add(uint x, uint y) external pure returns (uint) {
        // Using unchecked to skip overflow checking
        unchecked {
            return x + y;
        }
    }

    // Function to subtract two numbers without overflow checking
    function sub(uint x, uint y) external pure returns (uint) {
        // Using unchecked to skip overflow checking
        unchecked {
            return x - y;
        }
    }

    // Function to calculate the sum of squares without overflow checking
    function sumOfSquares(uint x, uint y) external pure returns (uint) {
        // Using unchecked to skip overflow checking
        unchecked {
            // Calculate the squares of x and y
            uint x2 = x * x;
            uint y2 = y * y;

            // Return the sum of the squares
            return x2 + y2;
        }
    }

    // Function to calculate the sum of cubes without overflow checking
    function sumOfCubes(uint x, uint y) external pure returns (uint) {
        // Using unchecked to skip overflow checking
        unchecked {
            // Calculate the cubes of x and y and return their sum
            return x * x * x + y * y * y;
        }
    }
}

/*
Here's an explanation of each part of the code:

1. The contract begins with SPDX license information and specifies the Solidity version.

2. The contract is named `UncheckedMath` and contains several functions for performing mathematical operations without overflow checking.

3. The `add` function adds two numbers `x` and `y` without checking for potential overflow. It uses the `unchecked` block to skip overflow checking.

4. The `sub` function subtracts `y` from `x` without checking for potential underflow. Like the `add` function, it uses the `unchecked` block to skip underflow checking.

5. The `sumOfSquares` function calculates the sum of the squares of two numbers `x` and `y` without checking for potential overflow. It first calculates the squares of `x` and `y`, and then returns the sum of these squares.

6. The `sumOfCubes` function calculates the sum of the cubes of two numbers `x` and `y` without checking for potential overflow. It directly computes the cubes of `x` and `y` and returns their sum.

In summary, this contract provides functions for performing basic arithmetic operations (addition and subtraction) as well as more complex operations (sum of squares and sum of cubes) without checking for overflow or underflow. It uses the `unchecked` block to explicitly skip the automatic overflow and underflow checks provided by Solidity, which can be useful in situations where the developer wants to handle overflow/underflow conditions manually for optimization or specific use cases. However, using `unchecked` requires caution, as it can lead to unexpected behavior if not used carefully.
*/