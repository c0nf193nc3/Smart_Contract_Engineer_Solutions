// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// gas golf
contract GasGolf {
    uint public total; // State variable to store the sum of even numbers less than 99

    // Function to calculate the sum of even numbers less than 99 from an input array
    function sumIfEvenAndLessThan99(uint[] calldata nums) external {
        uint _total = total; // Create a local variable to store the current total
        uint len = nums.length; // Get the length of the input array

        // Loop through the input array
        for (uint i = 0; i < len; ++i) {
            uint n = nums[i]; // Get the current number from the array
            if (n % 2 == 0 && n < 99) {
                // Check if the number is even and less than 99
                _total += n; // If so, add it to the local total
            }
        }

        total = _total; // Update the contract's total with the local total
    }
}

/*
Explanation of the code:

1. The "GasGolf" contract defines a state variable `total` to store the cumulative sum of even numbers less than 99.

2. The contract contains a single function named `sumIfEvenAndLessThan99` that takes an array of unsigned integers as input.

3. Inside the function:
   - It initializes a local variable `_total` with the current value of the `total` state variable. This is done to minimize state variable access, which can be costly in terms of gas.
   - It calculates the length of the input array `nums` and stores it in the `len` variable.
   - It enters a loop that iterates from `0` to `len - 1` to go through each element of the input array.
   - For each element `n` in the array:
     - It checks if `n` is even (`n % 2 == 0`) and if it is less than `99`.
     - If both conditions are met, it adds `n` to the local `_total`.
   - After processing all elements in the array, the local `_total` is assigned to the contract's state variable `total`, updating it with the new value.

The purpose of this contract is to efficiently calculate the sum of even numbers less than 99 from an input array while minimizing gas usage. It does so by avoiding unnecessary state variable reads and updates inside the loop, which can be gas-expensive operations in Ethereum smart contracts.
*/