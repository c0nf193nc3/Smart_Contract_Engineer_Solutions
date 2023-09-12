// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title EtherWallet
 * @dev This contract represents an Ether wallet that can receive and send Ether.
 */
contract EtherWallet {
    address payable public owner;

    /**
     * @dev Constructor for the EtherWallet contract.
     * Initializes the 'owner' state variable with the address of the contract deployer.
     * The 'owner' address is declared as 'payable', allowing it to receive Ether.
     */
    constructor() {
        owner = payable(msg.sender);
    }

    /**
     * @dev Receive function.
     * Executed when the contract receives Ether with a simple transfer, e.g., "address.transfer(value)".
     * Used to receive Ether into the contract.
     */
    receive() external payable {
        // Custom behavior for handling Ether transfers using the "receive" method.
    }

    /**
     * @dev Withdraw Ether from the contract.
     * @param _amount The amount of Ether to withdraw.
     */
    function withdraw(uint _amount) external {
        require(msg.sender == owner, "owner only");
        // Ensure that only the owner can initiate this function call. If not, revert with an error message.

        (bool sent, ) = owner.call{value: _amount}("");
        // Use the "call" function with the "value" field to send Ether from the contract to the owner.
        // The "value" field specifies the amount of Ether to send.

        require(sent, "Failed to send Ether");
        // If the call operation fails, revert with an error message.
    }
}
