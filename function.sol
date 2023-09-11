// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract FunctionIntro {
    // Declaring a Solidity smart contract named "FunctionIntro."

    function add(uint x, uint y) public pure returns (uint) {
        // Declaring a public function named "add" that takes two unsigned integer arguments, "x" and "y."
        // The "public" keyword allows anyone to call this function.
        // The "pure" keyword indicates that this function doesn't modify the contract's state.

        return x + y; // Perform addition of "x" and "y" and return the result.
    }
    
    function sub(uint x, uint y) public pure returns (uint) {
        // Declaring a public function named "sub" that takes two unsigned integer arguments, "x" and "y."
        // The "public" keyword allows anyone to call this function.
        // The "pure" keyword indicates that this function doesn't modify the contract's state.

        return x - y; // Perform subtraction of "y" from "x" and return the result.
    }
}
