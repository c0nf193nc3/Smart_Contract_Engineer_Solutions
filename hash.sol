// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Contract 'HashFunc' for demonstrating hash functions in Solidity.
contract HashFunc {
    // Function 'hash' takes a string, a uint, and an address as arguments and returns their keccak256 hash.
    function hash(
        string memory _text,
        uint _num,
        address _addr
    ) external pure returns (bytes32) {
        // Use abi.encodePacked to concatenate the input values and then calculate their keccak256 hash.
        return keccak256(abi.encodePacked(_text, _num, _addr));
    }

    // Function 'getHash' takes an address and a uint as arguments and returns their keccak256 hash.
    function getHash(address _addr, uint _num) external pure returns (bytes32) {
        // Use abi.encodePacked to concatenate the input values and then calculate their keccak256 hash.
        return keccak256(abi.encodePacked(_addr, _num));
    }
}