// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// A library named 'Math' for performing mathematical operations.
library Math {
    // Function to find the maximum of two unsigned integers.
    function max(uint x, uint y) internal pure returns (uint) {
        return x >= y ? x : y;
    }
    
    // Function to find the minimum of two unsigned integers.
    function min(uint x, uint y) internal pure returns (uint) {
        return x <= y ? x : y;
    }
}

// Contract 'TestMath' to test the 'Math' library.
contract TestMath {
    // Function to test the 'max' function of the 'Math' library.
    function testMax(uint x, uint y) external pure returns (uint) {
        return Math.max(x, y);
    }

    // Function to test the 'min' function of the 'Math' library.
    function testMin(uint x, uint y) external pure returns (uint) {
        return Math.min(x, y);
    }
}

// A library named 'ArrayLib' for performing operations on uint arrays.
library ArrayLib {
    // Function to find the index of a specific value in a uint array.
    function find(uint[] storage arr, uint x) internal view returns (uint) {
        for (uint i = 0; i < arr.length; i++) {
            if (arr[i] == x) {
                return i;
            }
        }
        revert("not found");
    }
    
    // Function to calculate the sum of all elements in a uint array.
    function sum(uint[] storage arr) internal view returns (uint) {
        uint total;
        for (uint i = 0; i < arr.length; i++) {
            total += arr[i];
        }
        return total;
    }
}

// Contract 'TestArray' to test the 'ArrayLib' library.
contract TestArray {
    // Import the 'ArrayLib' library for the 'arr' uint array.
    using ArrayLib for uint[];

    // A public uint array 'arr' initialized with [3, 2, 1].
    uint[] public arr = [3, 2, 1];

    // Function to test the 'find' function of the 'ArrayLib' library.
    function testFind() external view {
        arr.find(2);
    }

    // Function to test the 'sum' function of the 'ArrayLib' library.
    function testSum() external view returns (uint) {
        return arr.sum();
    }
}