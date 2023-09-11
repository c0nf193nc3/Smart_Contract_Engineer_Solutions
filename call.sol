// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract Call {
    // A Solidity smart contract named "Call."

    function callFoo(address payable _addr) public payable {
        // A public function "callFoo" that takes a payable address "_addr" as a parameter.

        (bool success, bytes memory data) = _addr.call{
            value: msg.value,
            gas: 5000
        }(abi.encodeWithSignature("foo(string,uint256)", "call foo", 123));
        // It uses the "_addr.call" function to invoke the "foo" function of the target contract at the provided address.
        // It attaches ether to the call using "msg.value" and sets a gas limit of 5000.
        // The function call is constructed using "abi.encodeWithSignature" with the function signature and arguments.

        require(success, "tx failed");
        // It checks if the function call was successful. If not, it raises an exception with the message "tx failed."
    }

    function callDoesNotExist(address _addr) public {
        // A public function "callDoesNotExist" that takes an address "_addr" as a parameter.

        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("doesNotExist()")
        );
        // It uses the "_addr.call" function to attempt to invoke a function "doesNotExist" on the target contract.
        // The function call is constructed using "abi.encodeWithSignature."

        // The result is stored in "success" and "data" variables, but this function does not check the success status.
        // It is just an example to show how to call a non-existing function.
    }

    function callBar(address _addr) public {
        // A public function "callBar" that takes an address "_addr" as a parameter.

        (bool success, ) = _addr.call(
            abi.encodeWithSignature("bar(uint256,bool)", 1, true)
        );
        // It uses the "_addr.call" function to invoke the "bar" function of the target contract at the provided address.
        // The function call is constructed using "abi.encodeWithSignature" with the function signature and arguments.

        require(success, "tx failed");
        // It checks if the function call was successful. If not, it raises an exception with the message "tx failed."
    }
}