// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title FunctionModifier
 * @notice A Solidity smart contract showcasing function modifiers for state management.
 */
contract FunctionModifier {
    bool public paused; // A public state variable to track whether the contract is paused.
    uint public count; // A public state variable to store a count value.

    /**
     * @dev Custom modifier to check if the contract is not paused.
     * @notice Reverts the transaction if the contract is paused.
     */
    modifier whenNotPaused() {
        require(!paused, "paused");
        _; // Function code will be executed here.
    }

    /**
     * @dev Custom modifier to check if the contract is paused.
     * @notice Reverts the transaction if the contract is not paused.
     */
    modifier whenPaused() {
        require(paused, "not paused");
        _; // Function code will be executed here.
    }

    /**
     * @dev Public function to update the "paused" state variable.
     * @param _paused The new pause status.
     * @notice Can be called to pause or unpause the contract.
     */
    function setPause(bool _paused) public {
        paused = _paused;
    }

    /**
     * @dev Public function to increment the "count" state variable.
     * @notice Can only be called when the contract is not paused.
     */
    function inc() public whenNotPaused {
        count += 1;
    }

    /**
     * @dev Public function to decrement the "count" state variable.
     * @notice Can only be called when the contract is not paused.
     */
    function dec() public whenNotPaused {
        count -= 1;
    }

    /**
     * @dev Custom modifier to check if the input value is less than 10.
     * @param _x The input value to check.
     * @notice Reverts the transaction if _x is greater than or equal to 10.
     */
    modifier cap(uint _x) {
        require(_x < 10, "x >= 10");
        _; // Function code will be executed here.
    }

    /**
     * @dev Public function to increment the "count" state variable by a specified value.
     * @param _x The value to increment by.
     * @notice Can only be called when the contract is not paused and _x is less than 10.
     */
    function incBy(uint _x) public whenNotPaused cap(_x) {
        count += _x;
    }

    /**
     * @dev Custom modifier example (sandwich).
     * @notice This modifier allows executing code before and after the function.
     */
    modifier sandwich() {
        // Code executed before the function.
        _; // Function code will be executed here.
        // Code executed after the function.
    }

    /**
     * @dev Public function to reset the "count" state variable to 0.
     * @notice Can only be called when the contract is paused.
     */
    function reset() public whenPaused {
        count = 0;
    }
}
