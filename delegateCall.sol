// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract DelegateCall {
    uint public num;        // Public state variable to store an integer.
    address public sender;  // Public state variable to store an address.
    uint public value;      // Public state variable to store an integer.

    // This function allows you to set variables in another contract using delegatecall.
    function setVars(address _test, uint _num) external payable {
        // Use delegatecall to call a function in another contract (_test).
        // The function to call is specified using abi.encodeWithSignature, along with the arguments (_num).
        // delegatecall executes the code in the context of this contract, but with the storage of _test.
        (bool success, bytes memory data) = _test.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
        
        // Check if the delegatecall was successful. If not, revert the transaction.
        require(success, "tx failed");
    }

    // This function also allows you to call a function in another contract (_test), but without delegatecall.
    function setNum(address _test, uint _num) external {
        // Use a regular external call to call a function in another contract (_test).
        // The function to call is specified using abi.encodeWithSignature, along with the arguments (_num).
        (bool success, ) = _test.delegatecall(
            abi.encodeWithSignature("setNum(uint256)", _num)
        );

        // Check if the call was successful. If not, revert the transaction.
        require(success, "tx failed");
    }
}