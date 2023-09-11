// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract VisibilityBase {
    // Declaring a Solidity smart contract named "VisibilityBase."

    uint private x = 0; // Declaring a private state variable "x" with an initial value of 0.
    uint internal y = 1; // Declaring an internal state variable "y" with an initial value of 1.
    uint public z = 2; // Declaring a public state variable "z" with an initial value of 2.

    function privateFunc() private pure returns (uint) {
        // A private function "privateFunc" that returns an unsigned integer (uint).
        return 0;
    }

    function internalFunc() internal pure returns (uint) {
        // An internal function "internalFunc" that returns an unsigned integer (uint).
        return 100;
    }

    function publicFunc() public pure returns (uint) {
        // A public function "publicFunc" that returns an unsigned integer (uint).
        return 200;
    }

    function externalFunc() external pure returns (uint) {
        // An external function "externalFunc" that returns an unsigned integer (uint).
        return 300;
    }

    function examples() external view {
        // A public external function "examples" that demonstrates the usage of various visibility modifiers and functions.
        
        x + y + z; // Accessing state variables with different visibility modifiers.

        privateFunc(); // Calling privateFunc within the same contract is allowed.
        internalFunc(); // Calling internalFunc within the same contract is allowed.
        publicFunc(); // Calling publicFunc within the same contract is allowed.

        this.externalFunc(); // Calling externalFunc via "this" is allowed within the same contract.
    }
}

contract VisibilityChild is VisibilityBase {
    // Declaring a Solidity smart contract named "VisibilityChild" that inherits from "VisibilityBase."

    function examples2() public view {
        // A public function "examples2" in the child contract that demonstrates the usage of inherited state variables and functions.
        
        y + z; // Accessing inherited state variables with different visibility modifiers.

        internalFunc(); // Calling internalFunc, inherited from the parent contract, is allowed.
        publicFunc(); // Calling publicFunc, inherited from the parent contract, is allowed.
    }

    function test() public view returns (uint) {
        // A public function "test" in the child contract that returns the sum of inherited state variables and function calls.
        
        return y + z + internalFunc() + publicFunc();
    }
}