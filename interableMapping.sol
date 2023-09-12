// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title IterableMapping
 * @dev This contract demonstrates an iterable mapping in Solidity.
 */
contract IterableMapping {
    mapping(address => uint) public balances;
    mapping(address => bool) public inserted;
    address[] public keys;

    /**
     * @dev Allows users to set the balance for a given address.
     * @param _addr The Ethereum address for which to set the balance.
     * @param _bal The balance value to set.
     */
    function set(address _addr, uint _bal) public {
        balances[_addr] = _bal;

        if (!inserted[_addr]) {
            inserted[_addr] = true;
            keys.push(_addr);
        }
    }

    /**
     * @dev Allows users to retrieve the balance associated with a specific index.
     * @param _index The index in the "keys" array to retrieve the balance from.
     * @return The balance associated with the specified address.
     */
    function get(uint _index) public view returns (uint) {
        address key = keys[_index];
        return balances[key];
    }

    /**
     * @dev Allows users to retrieve the balance associated with the first address in the "keys" array.
     * @return The balance associated with the first address.
     */
    function first() public view returns (uint) {
        return balances[keys[0]];
    }

    /**
     * @dev Allows users to retrieve the balance associated with the last address in the "keys" array.
     * @return The balance associated with the last address.
     */
    function last() public view returns (uint) {
        return balances[keys[keys.length - 1]];
    }
}
