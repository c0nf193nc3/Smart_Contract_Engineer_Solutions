// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title ForAndWhileLoops
 * @notice A Solidity smart contract showcasing for and while loops.
 */
contract ForAndWhileLoops {
    /**
     * @dev Function demonstrating for and while loops.
     */
    function loop() public pure {
        for (uint i = 0; i < 10; i++) {
            if (i == 3) {
                continue;
            }
            
            if (i == 5) {
                break;
            }
        }
        
        uint j;
        
        while (j < 10) {
            j++;
        }
    }

    /**
     * @dev Function to calculate the sum of numbers from 1 to n.
     * @param _n The input unsigned integer.
     * @return The sum of numbers from 1 to _n.
     */
    function sum(uint _n) public pure returns (uint) {
        uint add;
        
        for (uint i = 1; i <= _n; ++i) {
            add += i;
        }
        
        return add;
    }
}
