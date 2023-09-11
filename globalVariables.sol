// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title GlobalVariables
 * @notice A Solidity smart contract showcasing global variables and functions.
 */
contract GlobalVariables {
    /**
     * @dev Function to demonstrate global variables.
     * @return The sender's address, current timestamp, current block number, and block hash.
     */
    function globalVars() public view returns (address, uint, uint, bytes32) {
        address sender = msg.sender; // The sender's address.
        uint timeStamp = block.timestamp; // The current timestamp.
        uint blockNum = block.number; // The current block number.
        bytes32 blockHash = blockhash(block.number); // The hash of the current block.

        return (sender, timeStamp, blockNum, blockHash);
    }

    /**
     * @dev Function to return the sender's information.
     * @return The sender's address, current timestamp, current block number, and block hash.
     */
    function returnSender() public view returns (address, uint, uint, bytes32) {
        return (msg.sender, block.timestamp, block.number, blockhash(block.number));
    }
}
