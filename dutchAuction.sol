// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Define an interface for the ERC721 token standard
interface IERC721 {
    function transferFrom(address _from, address _to, uint _nftId) external;
}

// Define the DutchAuction contract
contract DutchAuction {
    uint private constant DURATION = 7 days;

    // Declare immutable state variables to store auction details
    IERC721 public immutable nft;          // The ERC721 token being auctioned
    uint public immutable nftId;            // The ID of the NFT within the ERC721 contract
    address payable public immutable seller; // The seller's address
    uint public immutable startingPrice;    // The initial price of the auction
    uint public immutable startAt;          // The auction start timestamp
    uint public immutable expiresAt;        // The auction expiration timestamp
    uint public immutable discountRate;     // The rate at which the price decreases over time

    constructor(
        uint _startingPrice,
        uint _discountRate,
        address _nft,
        uint _nftId
    ) {
        seller = payable(msg.sender);
        startingPrice = _startingPrice;
        startAt = block.timestamp;
        expiresAt = block.timestamp + DURATION;
        discountRate = _discountRate;

        // Ensure that the starting price is greater than or equal to the minimum price
        require(
            _startingPrice >= _discountRate * DURATION,
            "starting price < min"
        );

        // Initialize the NFT and NFT ID
        nft = IERC721(_nft);
        nftId = _nftId;
    }

    // Function to calculate the current price of the NFT based on the auction parameters
    function getPrice() public view returns (uint) {
        // Calculate the current price using the formula:
        // startingPrice - (discountRate * (timeElapsed))
        uint timeElapsed = block.timestamp - startAt;
        uint currentPrice = startingPrice - (discountRate * timeElapsed);
        // Ensure the current price doesn't go below zero
        if (currentPrice < 0) {
            return 0;
        }
        return currentPrice;
    }

    // Function to allow a user to purchase the NFT
    function buy() external payable {
        // Ensure that the auction is still active
        require(block.timestamp < expiresAt, "action is expired");

        // Calculate the current price
        uint currentPrice = getPrice();

        // Ensure that the sent Ether is greater than or equal to the current price
        require(msg.value >= currentPrice, "price is too low");

        // Transfer the NFT from the seller to the buyer
        nft.transferFrom(seller, msg.sender, nftId);

        // Calculate and transfer any excess Ether back to the buyer
        uint refund = msg.value - currentPrice;
        if (refund > 0) {
            payable(msg.sender).transfer(refund);
        }

        // Self-destruct the auction contract and send the proceeds to the seller
        selfdestruct(seller);
    }
}