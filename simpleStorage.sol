// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract SimpleStorage {
    // Declaring a Solidity smart contract named "SimpleStorage."

    string public text;
    // Declaring a public state variable "text" of type string. State variables are stored in "storage."

    function set(string calldata _text) public {
        // A public function named "set" that allows setting the value of the "text" variable.
        // The function takes a string argument "_text" declared as "calldata."

        text = _text;
        // Assigning the value of "_text" to the "text" state variable.
        // This operation stores the new value in "storage."
    }

    function get() public view returns (string memory) {
        // A public view function named "get" that allows retrieving the current value of the "text" variable.
        // It returns a string stored in "memory."

        return text;
        // Returning the current value of the "text" state variable.
        // This operation reads the value from "storage" and returns it to the caller.
    }
}