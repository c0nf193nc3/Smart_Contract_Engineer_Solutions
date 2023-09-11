// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract MappingBasic {
    // Declaring a Solidity smart contract named "MappingBasic."

    mapping(address => uint) public balances;
    // A public mapping that associates Ethereum addresses (address type) with unsigned integer values (uint).
    // This mapping is used to keep track of balances for different addresses.

    mapping(address => mapping(address => bool)) public isFriend;
    // A nested mapping that associates an Ethereum address (address type) with another mapping.
    // The nested mapping associates addresses with boolean values (true or false).
    // This mapping is used to represent a friendship relationship between addresses.

    function examples() public {
        // A public function named "examples" that demonstrates various mapping operations.

        balances[msg.sender] = 123;
        // Assigning the value 123 to the balance associated with the sender's Ethereum address (msg.sender).
        // This initializes the balance for the sender.

        uint bal = balances[msg.sender];
        // Reading the balance associated with the sender's Ethereum address and storing it in the "bal" variable.

        balances[msg.sender] += 456;
        // Updating the balance associated with the sender's Ethereum address by adding 456 to the existing balance.

        delete balances[msg.sender];
        // Deleting the balance associated with the sender's Ethereum address.
        // This resets the balance to its default value (zero for uint).

        isFriend[msg.sender][address(this)] = true;
        // Setting the friendship status between the sender's Ethereum address (msg.sender) and the contract's address (address(this)) to true.
        // This represents that the contract is a friend of the sender.
    }

    function get(address _addr) public view returns (uint) {
        // A public view function named "get" that retrieves the balance associated with a specified Ethereum address.

        return balances[_addr];
        // Returning the balance associated with the provided address "_addr."
    }

    function set(address _addr, uint _val) public {
        // A public function named "set" that allows setting the balance associated with a specified Ethereum address.

        balances[_addr] = _val;
        // Assigning the value "_val" to the balance associated with the provided address "_addr."
    }

    function remove(address _addr) public {
        // A public function named "remove" that allows deleting the balance associated with a specified Ethereum address.

        delete balances[_addr];
        // Deleting the balance associated with the provided address "_addr."
        // This resets the balance to its default value (zero for uint).
    }
}