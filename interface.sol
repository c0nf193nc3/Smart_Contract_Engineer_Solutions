// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

// You know what functions you can call, so you define an interface to TestInterface.
interface ITestInterface {
    function count() external view returns (uint);

    function inc() external;
    
    function dec() external;
}
// An interface named "ITestInterface" is declared to define the functions that must be implemented by contracts conforming to this interface.

// Contract that uses TestInterface interface to call TestInterface contract
contract CallInterface {
    // Declaring a Solidity smart contract named "CallInterface."

    function examples(address _test) external {
        // A public external function "examples" that takes an address "_test" as a parameter.

        ITestInterface(_test).inc();
        // It calls the "inc" function of the contract at the provided address, assuming the contract conforms to the "ITestInterface" interface.

        uint count = ITestInterface(_test).count();
        // It calls the "count" function of the contract at the provided address, assuming the contract conforms to the "ITestInterface" interface.
    }

    function dec(address _test) external {
        // A public external function "dec" that takes an address "_test" as a parameter.

        ITestInterface(_test).dec();
        // It calls the "dec" function of the contract at the provided address, assuming the contract conforms to the "ITestInterface" interface.
    }
}
