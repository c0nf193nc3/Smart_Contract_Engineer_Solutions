// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title LocalVariables
 * @notice A Solidity smart contract demonstrating local variables and functions.
 */
contract LocalVariables {
    /**
     * @dev Function to showcase local variables.
     * @return An uninitialized unsigned integer 'u' and an uninitialized boolean 'b'.
     */
    function localVars() public pure returns (uint, bool) {
        uint u; // Declaring a local unsigned integer variable "u" without initializing it.
        bool b; // Declaring a local boolean variable "b" without initializing it.

        return (u, b); // Returning the uninitialized local variables "u" and "b."
    }
    
    /**
     * @dev Function to multiply a constant.
     * @return The result of multiplying 123456 by itself.
     */
    function mul() public pure returns (uint) {
        uint x = 123456; // Declaring a local unsigned integer variable "x" and initializing it with the value 123456.

        return x * x; // Returning the result of multiplying "x" by itself, which is 123456 * 123456.
    }
}
