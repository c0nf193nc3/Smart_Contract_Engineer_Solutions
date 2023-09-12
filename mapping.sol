// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title MappingBasic
 * @dev This contract demonstrates basic mapping operations in Solidity.
 */
contract MappingBasic {
    mapping(address => uint) public balances;
    mapping(address => mapping(address => bool)) public isFriend;

    /**
     * @dev Demonstrates various mapping operations.
     */
    function examples() public {
        balances[msg.sender] = 123;
        uint bal = balances[msg.sender];
        balances[msg.sender] += 456;
        delete balances[msg.sender];
        isFriend[msg.sender][address(this)] = true;
    }

    /**
     * @dev Retrieves the balance associated with a specified Ethereum address.
     * @param _addr The Ethereum address for which to retrieve the balance.
     * @return The balance associated with the provided address.
     */
    function get(address _addr) public view returns (uint) {
        return balances[_addr];
    }

    /**
     * @dev Sets the balance associated with a specified Ethereum address.
     * @param _addr The Ethereum address for which to set the balance.
     * @param _val The balance value to set.
     */
    function set(address _addr, uint _val) public {
        balances[_addr] = _val;
    }

    /**
     * @dev Deletes the balance associated with a specified Ethereum address.
     * @param _addr The Ethereum address for which to delete the balance.
     */
    function remove(address _addr) public {
        delete balances[_addr];
    }
}
