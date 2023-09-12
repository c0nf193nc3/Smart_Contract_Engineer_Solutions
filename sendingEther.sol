// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title SendEther
 * @dev This contract provides functions for sending Ether using different methods.
 */
contract SendEther {
    /**
     * @dev Receive function.
     * Executed when the contract receives Ether with a simple transfer, e.g., "address.transfer(value)".
     */
    receive() external payable {
        // Custom behavior for handling Ether transfers using the "receive" method.
    }

    /**
     * @dev Send Ether to an address using the "transfer" method.
     * @param _to The address to which Ether is being sent.
     */
    function sendViaTransfer(address payable _to) external payable {
        _to.transfer(msg.value);
        // The "msg.value" represents the amount of Ether being sent with the function call.
        // The "transfer" function sends the Ether and reverts the transaction if it fails.
    }

    /**
     * @dev Send Ether to an address using the "send" method.
     * @param _to The address to which Ether is being sent.
     */
    function sendViaSend(address payable _to) external payable {
        bool sent = _to.send(msg.value);
        // The "msg.value" represents the amount of Ether being sent with the function call.
        // The "send" function returns a boolean indicating success or failure.

        require(sent, "Failed to send Ether");
        // If the send operation fails, the contract reverts with an error message.
    }

    /**
     * @dev Send Ether to an address using the "call" method.
     * @param _to The address to which Ether is being sent.
     */
    function sendViaCall(address payable _to) external payable {
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        // Using the "call" function with the "value" field to send Ether to the specified address "_to."
        // It returns a tuple with a boolean indicating success and a data field (usually empty for simple Ether transfers).

        require(sent, "Failed to send Ether");
        // If the call operation fails, the contract reverts with an error message.
    }

    /**
     * @dev Send a specific amount of Ether to an address using the "call" method.
     * @param _to The address to which Ether is being sent.
     * @param _amount The amount of Ether to send.
     */
    function sendEth(address payable _to, uint _amount) external {
        (bool sent, ) = _to.call{value: _amount}("");
        // Using the "call" function with the "value" field to send the specified "_amount" of Ether.

        require(sent, "Failed to send Ether");
        // If the call operation fails, the contract reverts with an error message.
    }
}
