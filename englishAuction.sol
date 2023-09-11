// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Define an interface for the ERC721 token standard
interface IERC721 {
    function transferFrom(address from, address to, uint nftId) external;
}

// Define the EnglishAuction contract
contract EnglishAuction {
    // Declare events to log important contract events
    event Start();
    event Bid(address indexed sender, uint amount);
    event Withdraw(address indexed bidder, uint amount);
    event End(address winner, uint amount);

    // Declare immutable state variables to store auction details
    IERC721 public immutable nft;           // The ERC721 token being auctioned
    uint public immutable nftId;             // The ID of the NFT within the ERC721 contract
    address payable public immutable seller; // The seller's address
    uint public endAt;                       // The timestamp when the auction ends
    bool public started;                     // Flag indicating if the auction has started
    bool public ended;                       // Flag indicating if the auction has ended
    address public highestBidder;            // The address of the current highest bidder
    uint public highestBid;                  // The value of the current highest bid
    // Mapping from bidder address to the amount they can withdraw
    mapping(address => uint) public bids;

    constructor(address _nft, uint _nftId, uint _startingBid) {
        // Initialize the auction contract with the provided parameters
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable(msg.sender);
        highestBid = _startingBid;
    }

    // Function to start the auction
    function start() external {
        require(msg.sender == seller, "seller only");
        require(!started, "already started");
        
        // Transfer the NFT to the contract for auction
        nft.transferFrom(seller, address(this), nftId);
        
        started = true;
        endAt = block.timestamp + 7 days; // The auction will end 7 days from now
        emit Start();
    }

    // Function for bidders to place bids
    function bid() external payable {
        require(started, "not started");
        require(!ended, "ended");
        require(msg.value > highestBid, "bid <= highestBid");
        
        // Refund the previous highest bidder
        bids[highestBidder] += highestBid;
        
        // Update the highest bidder and bid amount
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit Bid(msg.sender, msg.value);
    }

    // Function for bidders to withdraw their bid amount
    function withdraw() external {
        uint amount = bids[msg.sender];
        require(amount > 0, "amount = 0");
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

    // Function to end the auction
    function end() external {
        require(started && (block.timestamp >= endAt), "not ended");
        require(!ended, "ended");
        ended = true;
        
        if (highestBidder != address(0)) {
            // Transfer the NFT to the highest bidder
            nft.transferFrom(address(this), highestBidder, nftId);
            // Transfer the funds to the seller
            seller.transfer(highestBid);
        } else {
            // If there were no bidders, return the NFT to the seller
            nft.transferFrom(address(this), seller, nftId);
        }
        emit End(highestBidder, highestBid);
    }
}