// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract LocalVariables {
    // Declaring a Solidity smart contract named "LocalVariables."

    function localVars() public pure returns (uint, bool) {
        // Declaring a public function named "localVars" with no arguments.
        // This function is marked as "pure," meaning it doesn't modify the contract's state.

        uint u; // Declaring a local unsigned integer variable "u" without initializing it.
        bool b; // Declaring a local boolean variable "b" without initializing it.

        return (u, b); // Returning the uninitialized local variables "u" and "b."
    }
    
    function mul() public pure returns (uint) {
        // Declaring a public function named "mul" with no arguments.
        // This function is marked as "pure," meaning it doesn't modify the contract's state.

        uint x = 123456; // Declaring a local unsigned integer variable "x" and initializing it with the value 123456.

        return x * x; // Returning the result of multiplying "x" by itself, which is 123456 * 123456.
    }
}
