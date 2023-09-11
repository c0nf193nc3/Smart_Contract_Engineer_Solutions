// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract ForAndWhileLoops {
    // Declaring a Solidity smart contract named "ForAndWhileLoops."

    function loop() public pure {
        // Declaring a public pure function named "loop" with no arguments.
        
        for (uint i = 0; i < 10; i++) {
            // Using a for loop to iterate from 0 to 9 (inclusive).
            
            if (i == 3) {
                // If the loop variable "i" is equal to 3, continue to the next iteration.
                continue;
            }
            
            if (i == 5) {
                // If the loop variable "i" is equal to 5, exit the loop.
                break;
            }
        }
        
        uint j; // Declaring an unsigned integer variable "j" for the while loop.
        
        while (j < 10) {
            // Using a while loop to increment "j" until it becomes greater than or equal to 10.
            j++;
        }
    }

    function sum(uint _n) public pure returns (uint) {
        // Declaring a public pure function named "sum" that takes an unsigned integer argument "_n" and returns an unsigned integer.

        uint add; // Declaring a local unsigned integer variable "add" to store the sum.
        
        for (uint i = 1; i <= _n; ++i) {
            // Using a for loop to calculate the sum of numbers from 1 to "_n".
            add += i; // Adding the current value of "i" to the "add" variable.
        }
        
        return add; // Returning the computed sum.
    }
}