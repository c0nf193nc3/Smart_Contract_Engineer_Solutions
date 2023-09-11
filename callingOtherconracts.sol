// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

import "./anycontract.sol"; // Importing the "anycontract.sol" contract for interaction.

contract CallTestContract {
    // Declaring a Solidity smart contract named "CallTestContract."

    function setX(TestContract _test, uint _x) external {
        // A public external function "setX" that takes a "TestContract" instance and an unsigned integer "_x" as parameters.
        // It calls the "setX" function of the provided "_test" contract instance.

        _test.setX(_x);
    }

    function setXfromAddress(address _addr, uint _x) external {
        // A public external function "setXfromAddress" that takes an address "_addr" and an unsigned integer "_x" as parameters.
        // It creates a new "TestContract" instance using the provided address and calls the "setX" function on it.

        TestContract test = TestContract(_addr);
        test.setX(_x);
    }

    function getX(address _addr) external view returns (uint) {
        // A public external function "getX" that takes an address "_addr" as a parameter.
        // It calls the "getX" function of the contract at the provided address and returns the result.

        uint x = TestContract(_addr).getX();
        return x;
    }

    function setXandSendEther(TestContract _test, uint _x) external payable {
        // A public external function "setXandSendEther" that takes a "TestContract" instance and an unsigned integer "_x" as parameters.
        // It sends Ether to the "_test" contract instance by calling the "setXandReceiveEther" function with the specified value.

        _test.setXandReceiveEther{value: msg.value}(_x);
    }

    function getXandValue(address _addr) external view returns (uint, uint) {
        // A public external function "getXandValue" that takes an address "_addr" as a parameter.
        // It calls the "getXandValue" function of the contract at the provided address and returns both the result and the value of Ether received.

        (uint x, uint value) = TestContract(_addr).getXandValue();
        return (x, value);
    }

    function setXwithEther(address _addr) external payable {
        // A public external function "setXwithEther" that takes an address "_addr" as a parameter.
        // It sends Ether to the "_addr" contract instance by calling the "setXtoValue" function with the specified value.

        TestContract(_addr).setXtoValue{value: msg.value}();
    }

    function getValue(address _addr) external view returns (uint) {
        // A public external function "getValue" that takes an address "_addr" as a parameter.
        // It calls the "getValue" function of the contract at the provided address and returns the result.

        return TestContract(_addr).getValue();
    }
}