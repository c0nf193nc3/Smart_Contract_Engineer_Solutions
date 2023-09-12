// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title EnumExamples
 * @dev This contract demonstrates the use of enums in Solidity to represent shipping status.
 */
contract EnumExamples {
    enum Status {
        None,      // 0
        Pending,   // 1
        Shipped,   // 2
        Completed, // 3
        Rejected,  // 4
        Canceled   // 5
    }

    Status public status;

    /**
     * @dev Retrieves the current shipping status.
     * @return The current shipping status.
     */
    function get() public view returns (Status) {
        return status;
    }

    /**
     * @dev Sets the shipping status to a specified value.
     * @param _status The new shipping status.
     */
    function set(Status _status) public {
        status = _status;
    }

    /**
     * @dev Sets the shipping status to "Canceled."
     */
    function cancel() public {
        status = Status.Canceled;
    }

    /**
     * @dev Deletes the shipping status.
     */
    function reset() public {
        delete status;
    }

    /**
     * @dev Sets the shipping status to "Shipped."
     */
    function ship() public {
        status = Status.Shipped;
    }
}
