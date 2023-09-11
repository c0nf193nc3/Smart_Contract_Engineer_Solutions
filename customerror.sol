// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract CustomError {
    // Define custom errors
    error MyError(address caller, uint i);
    error InvalidAddress();
    error NotAuthorized(address caller);

    // Declare a public state variable to store the contract owner's address
    address public owner = msg.sender;

    // Function to test custom error "MyError"
    function testMyError(uint i) external {
        // Check if the input value "i" is less than 10
        if (i < 10) {
            // Revert the transaction with the custom error "MyError" and provide the caller's address and the value of "i"
            revert MyError(msg.sender, i);
        }
    }

    // Function to set the contract owner
    function setOwner(address _owner) external {
        // Check if the provided address is invalid (zero address)
        if (_owner == address(0)) {
            // Revert the transaction with the custom error "InvalidAddress"
            revert InvalidAddress();
        }
        // Check if the sender is not the current owner
        if (msg.sender != owner) {
            // Revert the transaction with the custom error "NotAuthorized" and provide the caller's address
            revert NotAuthorized(msg.sender);
        }
        // Update the contract owner to the new address
        owner = _owner;
    }
}
/*
Here's an explanation of each part of the code:

1. The contract begins with SPDX license information and specifies the Solidity version.

2. The contract is named `CustomError` and contains custom error definitions using the `error` keyword. Three custom errors are defined:
   - `MyError(address caller, uint i)`: This error takes two parameters - the caller's address and an unsigned integer `i`. It can be used to revert a transaction with custom error information.
   - `InvalidAddress()`: This error represents an invalid address (zero address) and can be used to revert a transaction when an invalid address is provided.
   - `NotAuthorized(address caller)`: This error takes the caller's address as a parameter and can be used to revert a transaction when the sender is not authorized.

3. A public state variable `owner` is declared to store the address of the contract owner. It is initialized with the address of the contract deployer (`msg.sender`).

4. The `testMyError` function takes an unsigned integer `i` as an argument. It checks if `i` is less than 10, and if so, it reverts the transaction with the custom error `MyError`, providing the caller's address (`msg.sender`) and the value of `i`.

5. The `setOwner` function allows changing the contract owner. It takes a new owner's address `_owner` as an argument.
   - It first checks if the provided `_owner` address is invalid (zero address). If so, it reverts the transaction with the custom error `InvalidAddress`.
   - It then checks if the sender of the transaction is the current owner. If not, it reverts the transaction with the custom error `NotAuthorized`, providing the caller's address.
   - If both checks pass, it updates the contract owner to the new address `_owner`.

In summary, this contract demonstrates the use of custom errors in Solidity to provide detailed information when reverting transactions. It defines custom errors for specific scenarios, such as an invalid address or unauthorized access. The contract also includes functions that use these custom errors to revert transactions when certain conditions are not met.
*/