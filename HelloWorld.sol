// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

/// @title HelloWorld
/// @notice A simple Solidity smart contract that stores a greeting message.
contract HelloWorld {
    string public welcome = "Hello World";
    // Declaring a public string variable named "welcome" and initializing it with the value "Hello World."
    // The "public" keyword allows anyone to read the value of this variable.
    
    /// @notice Get the current greeting message.
    /// @return The greeting message.
    function getGreeting() public view returns (string memory) {
        return welcome;
    }
}
