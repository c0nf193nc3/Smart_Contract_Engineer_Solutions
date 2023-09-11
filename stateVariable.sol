// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract StateVariables {
    // Declaring a Solidity smart contract named "StateVariables."

    uint public num;
    // Declaring a public unsigned integer state variable named "num."
    // This variable can be read by anyone and modified by the contract's functions.

    function setNum(uint _num) external {
        // Declaring a public external function named "setNum" that takes an unsigned integer argument "_num."
        // The "external" keyword indicates that this function can be called from outside the contract.

        num = _num; // Set the value of the "num" state variable to the provided "_num" value.
    }

    // View - "view" is a read-only function.

    function getNum() public view returns (uint) {
        // Declaring a public view function named "getNum."
        // The "public" keyword allows anyone to call this function, and "view" indicates that it doesn't modify the contract's state.

        return num; // Return the current value of the "num" state variable.
    }
    
    function resetNum() public {
        // Declaring a public function named "resetNum."

        num = 0; // Reset the value of the "num" state variable to 0.
    }
    
    function getNumPlusOne() public view returns (uint) {
        // Declaring a public view function named "getNumPlusOne."

        return num + 1; // Return the current value of "num" incremented by 1.
    }
}
