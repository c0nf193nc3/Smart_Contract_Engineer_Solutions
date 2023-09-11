// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract ViewAndPureFunctions {
    // Declaring a Solidity smart contract named "ViewAndPureFunctions."

    uint public num;
    // Declaring a public unsigned integer state variable named "num."

    function viewFunc() public view returns (uint) {
        // Declaring a public view function named "viewFunc" with no arguments.
        // This function is marked as "view," indicating that it only reads the contract's state and doesn't modify it.

        return num; // Return the current value of the "num" state variable.
    }

    function pureFunc() public pure returns (uint) {
        // Declaring a public pure function named "pureFunc" with no arguments.
        // This function is marked as "pure," meaning it doesn't read or modify the contract's state.

        return 1; // Return the constant value 1.
    }
    
    function addToNum(uint x) public view returns (uint) {
        // Declaring a public view function named "addToNum" that takes an unsigned integer argument "x."
        // This function is marked as "view," as it reads the contract's state.

        return num + x; // Return the result of adding "x" to the current value of the "num" state variable.
    }
    
    function add(uint x, uint y) public pure returns (uint) {
        // Declaring a public pure function named "add" that takes two unsigned integer arguments, "x" and "y."
        // This function is marked as "pure" and doesn't read or modify the contract's state.

        return x + y; // Return the result of adding "x" and "y."
    }
}