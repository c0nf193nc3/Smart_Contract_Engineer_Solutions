// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title HelloWorld
 * @notice A simple Solidity smart contract that stores a greeting message.
 */
contract HelloWorld {
    /**
     * @dev Stores the greeting message.
     * @return The greeting message.
     */
    string public welcome = "Hello World";

    /**
     * @dev Get the current greeting message.
     * @return The greeting message.
     */
    function getGreeting() public view returns (string memory) {
        return welcome;
    }
}
