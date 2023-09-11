// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./IERC20Permit.sol";

contract GaslessTokenTransfer {
    // This function allows gasless token transfers.
    // It uses the EIP-2612 permit function to approve token transfers on behalf of the sender.

    function send(
        address token,
        address sender,
        address receiver,
        uint256 amount,   // Amount to send to receiver
        uint256 fee,      // Fee paid to msg.sender
        uint256 deadline, // Deadline for permit
        uint8 v,          // ECDSA signature recovery id
        bytes32 r,        // ECDSA signature r
        bytes32 s         // ECDSA signature s
    ) external {
        // First, the function calls the `permit` function of the ERC20 token contract
        // to approve token spending by the sender (msg.sender) on behalf of the sender.
        // This is done to cover both the main transfer and the fee transfer.
        
        // The permit function allows the token owner to approve a specific spender
        // (in this case, the contract) to spend tokens on their behalf without the need
        // for a direct transaction and gas payment.

        // Here, `amount + fee` tokens are approved to be spent.
        IERC20Permit(token).permit(sender, address(this), amount + fee, deadline, v, r, s);
        
        // After obtaining the permit, the contract transfers `amount` tokens from the sender
        // to the receiver. This represents the main token transfer.
        IERC20Permit(token).transferFrom(sender, receiver, amount);
        
        // Then, the contract transfers the `fee` amount of tokens from the sender to itself
        // (the contract). This represents the fee paid for the gasless transfer.
        IERC20Permit(token).transferFrom(sender, msg.sender, fee);
    }
}
