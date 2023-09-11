// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract Ownable {
    // Declaring a Solidity smart contract named "Ownable."

    address public owner; // A public state variable to store the contract owner's address.

    constructor() {
        // A constructor function, named the same as the contract, which is executed only once during contract deployment.

        owner = msg.sender;
        // Assigning the address of the contract deployer (the sender of the deployment transaction) to the "owner" state variable.
        // This effectively sets the contract deployer as the owner when the contract is deployed.
    }

    modifier onlyOwner() {
        // Declaring a custom modifier named "onlyOwner."
        // Modifiers are used to add custom conditions to functions.

        require(msg.sender == owner, "not owner");
        // Using "require" to check if the sender of the transaction is the same as the contract owner.
        // If the sender is not the owner, it reverts the transaction with an error message "not owner."

        _; // The underscore represents the location where the actual function code will be executed.
        // In this case, the function code is placed between this modifier and "_;" and will only execute if the sender is the owner.
    }

    function setOwner(address _newOwner) public onlyOwner {
        // A public function named "setOwner" that allows the current owner to transfer ownership to a new address.

        require(_newOwner != address(0), "new owner = zero address");
        // Using "require" to check if the new owner's address is not the zero address.
        // If it's the zero address, the transaction is reverted with an error message "new owner = zero address."

        owner = _newOwner;
        // Assigning the provided "_newOwner" address as the new owner of the contract.
    }
}