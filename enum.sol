// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract EnumExamples {
    // Declaring a Solidity smart contract named "EnumExamples."

    enum Status {
        // Defining an enum type named "Status" to represent shipping status.
        // Enums are used to create a set of named constant values.

        None,      // 0
        Pending,   // 1
        Shipped,   // 2
        Completed, // 3
        Rejected,  // 4
        Canceled   // 5
    }

    Status public status;
    // Declaring a public state variable of the "Status" enum type to store the current shipping status.

    function get() public view returns (Status) {
        // A public view function named "get" that retrieves the current shipping status.

        return status;
        // Returning the value of the "status" variable, which represents the current shipping status.
    }

    function set(Status _status) public {
        // A public function named "set" that allows setting the shipping status to a specified value.

        status = _status;
        // Assigning the provided "_status" value to the "status" variable.
    }

    function cancel() public {
        // A public function named "cancel" that sets the shipping status to "Canceled."

        status = Status.Canceled;
        // Assigning the "Canceled" enum value to the "status" variable.
    }

    function reset() public {
        // A public function named "reset" that deletes the shipping status.

        delete status;
        // Deleting the value of the "status" variable, which resets it to the default enum value (None).
    }

    function ship() public {
        // A public function named "ship" that sets the shipping status to "Shipped."

        status = Status.Shipped;
        // Assigning the "Shipped" enum value to the "status" variable.
    }
}