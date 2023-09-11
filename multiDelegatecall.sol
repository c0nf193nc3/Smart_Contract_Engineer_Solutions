// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract MultiDelegatecall {
    function multiDelegatecall(
        bytes[] calldata data
    ) external payable returns (bytes[] memory results) {
        // Create a dynamic array to store the results of delegate calls
        bytes[] memory results = new bytes[](data.length);

        // Iterate through each data payload and execute a delegatecall
        for (uint i = 0; i < data.length; i++) {
            // Execute a delegatecall to the current contract address with the provided data
            // Delegatecall is used to execute the code of another contract while preserving the caller's context
            (bool success, bytes memory result) = address(this).delegatecall(data[i]);

            // Check if the delegatecall was successful, and if not, revert the transaction
            require(success, "call failed");

            // Store the result of the delegatecall in the results array
            results[i] = result;
        }

        // Return the array of results from delegate calls
        return results;
    }
}

// The TestMultiDelegatecall contract inherits from MultiDelegatecall
contract TestMultiDelegatecall is MultiDelegatecall {
    event Log(address caller, string func, uint i);

    // Function func1 accepts two uint parameters, emits an event, and adds them to calculate 'x + y'
    function func1(uint x, uint y) external {
        emit Log(msg.sender, "func1", x + y);
    }

    // Function func2 returns a uint, emits an event, and returns the constant value '111'
    function func2() external returns (uint) {
        emit Log(msg.sender, "func2", 2);
        return 111;
    }
}

/*

Here's the explanation of the code:

1. The "MultiDelegatecall" contract provides a function called "multiDelegatecall" that takes an array of `bytes` called "data" as input. It executes delegate calls to multiple functions specified by the provided data and returns an array of results.

2. Inside the "multiDelegatecall" function:
   - It initializes a dynamic array called "results" to store the results of delegate calls.
   - It iterates through the "data" array, executing a delegate call for each element.
   - For each delegate call, it checks if the call was successful using the "success" boolean flag.
   - If a delegate call fails, it reverts the transaction with an error message.
   - It stores the result of each delegate call in the "results" array.
   - Finally, it returns the "results" array containing the results of all delegate calls.

3. The "TestMultiDelegatecall" contract inherits from the "MultiDelegatecall" contract and demonstrates the usage of the delegate call functionality.

4. Inside the "TestMultiDelegatecall" contract:
   - It defines two functions, "func1" and "func2," which are meant to be called using delegate calls.
   - "func1" accepts two parameters, emits an event called "Log," and calculates the sum of the parameters "x" and "y."
   - "func2" returns a constant value of 111, emits an event called "Log," and returns the constant value.

By using the "multiDelegatecall" function from the "MultiDelegatecall" contract, you can execute multiple delegate calls in a single transaction and retrieve the results. The "TestMultiDelegatecall" contract demonstrates how to call these functions using delegate calls.

If you have any further questions or need additional clarification, please feel free to ask!
*/
