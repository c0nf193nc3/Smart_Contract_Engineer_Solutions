// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./AggregatorV3Interface.sol";

contract PriceOracle {
    // Define a constant variable that represents the address of the Chainlink price oracle contract.
    // This address is used to interact with the external oracle contract.
    AggregatorV3Interface private constant priceOracle = 
        AggregatorV3Interface(0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c);
    
    // Function to get the latest price from the oracle contract.
    function getPrice() public view returns (int) {
        // Call the `latestRoundData` function of the Chainlink oracle contract
        // to retrieve the latest price data.
        (
            uint80 roundId,
            int answer,
            uint startedAt,
            uint updatedAt,
            uint80 answeredInRound
        ) = priceOracle.latestRoundData();
        
        // Check if the retrieved price data is not stale by comparing the timestamp
        // of the last update (`updatedAt`) with the current block timestamp.
        require(updatedAt >= block.timestamp - 3 * 3600, "stale price");
        
        // Return the latest price adjusted by a factor of 1e10.
        // This is done to ensure that the price has the correct decimal places.
        return answer * 1e10;
    }
}
