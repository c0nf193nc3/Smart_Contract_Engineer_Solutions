// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title Fallback
 * @dev This contract represents a contract with a fallback and receive function to handle Ether transfers.
 */
contract Fallback {
    string[] public answers = ["receive", "fallback"];

    /**
     * @dev Fallback function.
     * Executed when the contract receives Ether without a specific function call or when a function call fails.
     * Used for custom behavior when funds are sent to the contract.
     */
    fallback() external payable {
        // Custom behavior for handling unexpected Ether transfers or failed function calls.
    }

    /**
     * @dev Receive function.
     * Executed when the contract receives Ether with a simple transfer, e.g., "address.transfer(value)".
     * A newer and more efficient way to handle Ether transfers compared to the fallback function.
     */
    receive() external payable {
        // Custom behavior for handling Ether transfers using "receive" method.
    }
}
