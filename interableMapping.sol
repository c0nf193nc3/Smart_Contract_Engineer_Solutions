// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract IterableMapping {
    // Declaring a Solidity smart contract named "IterableMapping."

    mapping(address => uint) public balances;
    // Declaring a public mapping named "balances" that associates Ethereum addresses with unsigned integers (balances).
    // This mapping allows anyone to read balances associated with specific addresses.

    mapping(address => bool) public inserted;
    // Declaring another public mapping named "inserted" that associates Ethereum addresses with boolean values.
    // It is used to keep track of whether an address has been inserted into the "keys" array.

    address[] public keys;
    // Declaring a public dynamic array of Ethereum addresses named "keys."
    // This array is used to store the keys (addresses) associated with the "balances" mapping.
    // It is publicly accessible.

    function set(address _addr, uint _bal) public {
        // A public function named "set" that allows users to set the balance for a given address.
        // It takes two arguments: the Ethereum address "_addr" and the balance "_bal" to set.

        balances[_addr] = _bal;
        // Setting the balance associated with the provided address "_addr" to the provided balance "_bal."

        if (!inserted[_addr]) {
            // Checking whether the provided address "_addr" has been inserted into the "keys" array.
            
            inserted[_addr] = true;
            // Marking the address as inserted by setting its value to "true" in the "inserted" mapping.

            keys.push(_addr);
            // Adding the address to the end of the "keys" array.
        }
    }

    function get(uint _index) public view returns (uint) {
        // A public view function named "get" that allows users to retrieve the balance associated with a specific index.
        // It takes an integer "_index" as an argument, representing the index in the "keys" array.

        address key = keys[_index];
        // Retrieving the address (key) at the specified index from the "keys" array.

        return balances[key];
        // Returning the balance associated with the retrieved address (key) from the "balances" mapping.
    }

    function first() public view returns (uint) {
        // A public view function named "first" that allows users to retrieve the balance associated with the first address in the "keys" array.

        return balances[keys[0]];
        // Retrieving and returning the balance associated with the first address in the "keys" array.
    }

    function last() public view returns (uint) {
        // A public view function named "last" that allows users to retrieve the balance associated with the last address in the "keys" array.

        return balances[keys[keys.length - 1]];
        // Retrieving and returning the balance associated with the last address in the "keys" array.
    }
}