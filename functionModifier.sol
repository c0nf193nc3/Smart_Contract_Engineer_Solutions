// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract FunctionModifier {
    // Declaring a Solidity smart contract named "FunctionModifier."

    bool public paused; // A public state variable to track whether the contract is paused.
    uint public count; // A public state variable to store a count value.

    modifier whenNotPaused() {
        // Declaring a custom modifier named "whenNotPaused."
        // Modifiers are used to add custom conditions to functions.

        require(!paused, "paused");
        // Using "require" to check if the contract is not paused. If it's paused, revert the transaction with an error message.

        _; // The underscore represents the location where the actual function code will be executed.
        // In this case, the function code is placed between this modifier and "_;".
    }
    
    modifier whenPaused() {
        // Declaring a custom modifier named "whenPaused."

        require(paused, "not paused");
        // Using "require" to check if the contract is paused. If it's not paused, revert the transaction with an error message.

        _;
    }

    function setPause(bool _paused) public {
        // A public function named "setPause" to update the "paused" state variable.

        paused = _paused;
        // Updates the "paused" state variable based on the provided input.
    }

    // This function will throw an error if paused
    function inc() public whenNotPaused {
        // A public function named "inc" that increments the "count" state variable.

        count += 1;
        // This function uses the "whenNotPaused" modifier to ensure that it can only be executed when the contract is not paused.
    }

    function dec() public whenNotPaused {
        // A public function named "dec" that decrements the "count" state variable.

        count -= 1;
        // This function also uses the "whenNotPaused" modifier to ensure it's not executed when the contract is paused.
    }

    modifier cap(uint _x) {
        // Declaring a custom modifier named "cap."
        // Modifiers can also take input and check it.

        require(_x < 10, "x >= 10");
        // Using "require" to check if the input value "_x" is less than 10. If it's not, revert the transaction with an error message.

        _;
    }

    function incBy(uint _x) public whenNotPaused cap(_x) {
        // A public function named "incBy" that increments the "count" state variable by a specified value.

        count += _x;
        // This function uses both the "whenNotPaused" and "cap" modifiers to ensure it's not executed when the contract is paused
        // and that the input value "_x" is less than 10.
    }
    
    modifier sandwich() {
        // Declaring a custom modifier named "sandwich."
        // Modifiers can execute code before and after the function or depend on many requirements.

        // code before the function
        _; // This represents the location where the actual function code will be executed.
        // In this case, the function code is placed between this modifier and "_;".
        // code after the function
    }
    
    function reset() public whenPaused {
        // A public function named "reset" that sets the "count" state variable to 0.
        // It can only be executed when the contract is paused.

        count = 0;
    }
}