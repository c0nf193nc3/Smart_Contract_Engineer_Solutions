// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract Fallback {
    // Declaring a Solidity smart contract named "Fallback."

    string[] public answers = ["receive", "fallback"];
    // Declaring a public state variable "answers" as an array of strings to store two answers.

    fallback() external payable {
        // The fallback function, declared as external and payable.
        // This function is executed when the contract receives Ether without a specific function call or when a function call fails.

        // It is common to use the fallback function to handle unexpected Ether transfers or to provide custom behavior when funds are sent to the contract.
    }

    receive() external payable {
        // The receive function, declared as external and payable.
        // This function is executed when the contract receives Ether with a simple transfer, such as "address.transfer(value)".

        // It is a newer and more efficient way to handle Ether transfers compared to the fallback function.
    }
}