// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract MultiCall {
    // Function multiCall allows for batch execution of external contract calls
    function multiCall(
        address[] calldata targets, // An array of target contract addresses
        bytes[] calldata data       // An array of data to be sent to the corresponding target contracts
    ) external view returns (bytes[] memory) {
        // Ensure that the number of targets matches the number of data items
        require(targets.length == data.length, "targets.length != data.length");
        
        // Create an array to store the results of the external calls
        bytes[] memory results = new bytes[](data.length);
        
        // Loop through each target contract and data item
        for (uint i = 0; i < targets.length; i++) {
            // Use the staticcall function to make an external call to the target contract
            // The staticcall function is used for view and pure functions and does not modify the blockchain state
            (bool success, bytes memory result) = targets[i].staticcall(data[i]);
            
            // Check if the external call was successful, and if not, revert the transaction
            require(success, "call failed");
            
            // Store the result of the call in the results array
            results[i] = result;
        }

        // Return an array containing the results of all the external calls
        return results;
    }
}