// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Kill {
    // Function to self-destruct (destroy) the contract and send its balance to the caller.
    function kill() external {
        // The "selfdestruct" function is used to destroy the contract and send its remaining balance to a specified address.
        // In this case, "payable(msg.sender)" ensures that the balance is sent to the caller of the "kill" function (the contract owner).
        selfdestruct(payable(msg.sender));
    }
}
