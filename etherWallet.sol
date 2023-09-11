// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract EtherWallet {
    // Declaring a Solidity smart contract named "EtherWallet."

    address payable public owner;
    // Declaring a public state variable named "owner" with the `payable` keyword.
    // The `payable` keyword indicates that this address can receive Ether.

    constructor() {
        owner = payable(msg.sender);
        // The constructor function is executed once during contract deployment.
        // It assigns the address of the contract creator (msg.sender) to the "owner" state variable.
        // The "owner" address is declared as `payable`, allowing it to receive Ether.
    }
    
    receive() external payable {
        // The receive function, declared as external and payable.
        // This function is executed when the contract receives Ether with a simple transfer, such as "address.transfer(value)".
        // It can be used to receive Ether into the contract.
    }
    
    function withdraw(uint _amount) external {
        // A public external function named "withdraw" for allowing the owner to withdraw Ether from the contract.

        require(msg.sender == owner, "owner only");
        // Ensuring that only the owner can initiate this function call. If the caller is not the owner, the function will revert with an error message.

        (bool sent, ) = owner.call{value: _amount}("");
        // Using the "call" function with the "value" field to send Ether from the contract to the owner.
        // The "value" field specifies the amount of Ether to send.

        require(sent, "Failed to send Ether");
        // If the call operation fails, the contract reverts with an error message.
    }
}