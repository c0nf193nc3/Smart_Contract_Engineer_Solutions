// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract GlobalVariables {
    // Declaring a Solidity smart contract named "GlobalVariables."

    function globalVars() public view returns (address, uint, uint, bytes32) {
        // Declaring a public view function named "globalVars."
        // The "public" keyword allows anyone to call this function, and "view" indicates that it doesn't modify the contract's state.

        address sender = msg.sender; // Declaring a local variable "sender" and assigning it the value of the sender's address.
        // `msg.sender` represents the address of the account that called the contract function.

        uint timeStamp = block.timestamp; // Declaring a local variable "timeStamp" and assigning it the current timestamp.
        // `block.timestamp` provides the timestamp of the current block when the function is called.

        uint blockNum = block.number; // Declaring a local variable "blockNum" and assigning it the current block number.
        // `block.number` gives the block number of the current block.

        bytes32 blockHash = blockhash(block.number); // Declaring a local variable "blockHash" and assigning it the hash of a given block.
        // `blockhash(block.number)` provides the hash of the block specified by the block number.

        return (sender, timeStamp, blockNum, blockHash); // Returning the values of "sender," "timeStamp," "blockNum," and "blockHash."
    }
    
    // The below function can be optional.
    function returnSender() public view returns (address, uint, uint, bytes32) {
        // Declaring a public view function named "returnSender."
        // This function essentially provides the same information as "globalVars."

        return (msg.sender, block.timestamp, block.number, blockhash(block.number));
        // Returning the sender's address, current timestamp, current block number, and block hash of the current block.
    }
}
