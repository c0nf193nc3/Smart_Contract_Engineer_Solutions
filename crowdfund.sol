// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./IERC20.sol";

contract CrowdFund {
    // Events to log various contract actions
    event Launch(
        uint id,
        address indexed creator,
        uint goal,
        uint32 startAt,
        uint32 endAt
    );
    event Cancel(uint id);
    event Pledge(uint indexed id, address indexed caller, uint amount);
    event Unpledge(uint indexed id, address indexed caller, uint amount);
    event Claim(uint id);
    event Refund(uint id, address indexed caller, uint amount);

    // Struct to represent campaign details
    struct Campaign {
        address creator; // Creator of the campaign
        uint goal;       // Amount of tokens to raise
        uint pledged;    // Total amount pledged
        uint32 startAt;  // Timestamp of start of campaign
        uint32 endAt;    // Timestamp of end of campaign
        bool claimed;    // True if the goal was reached and creator has claimed the tokens
    }

    IERC20 public immutable token; // Address of the ERC20 token
    uint public count; // Total count of campaigns created
    mapping(uint => Campaign) public campaigns; // Mapping from campaign ID to Campaign
    mapping(uint => mapping(address => uint)) public pledgedAmount; // Mapping from campaign ID => pledger => amount pledged

    constructor(address _token) {
        token = IERC20(_token);
    }

    // Function to create a new campaign
    function launch(uint _goal, uint32 _startAt, uint32 _endAt) external {
        require(_startAt >= block.timestamp, "wrong _startAt");
        require(_startAt <= _endAt, "_startAt > _endAt");
        require(_endAt <= block.timestamp + 90 days, "more than 90 days");

        count += 1;
        campaigns[count] = Campaign(msg.sender, _goal, 0, _startAt, _endAt, false);
        emit Launch(count, msg.sender, _goal, _startAt, _endAt);
    }

    // Function to cancel a campaign
    function cancel(uint _id) external {
        require(msg.sender == campaigns[_id].creator, "only creator");
        require(campaigns[_id].startAt > block.timestamp, "already started");

        delete campaigns[_id];
        emit Cancel(_id);
    }

    // Function to pledge tokens to a campaign
    function pledge(uint _id, uint _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(campaign.startAt <= block.timestamp, "not started");
        require(campaign.endAt >= block.timestamp, "ended");

        token.transferFrom(msg.sender, address(this), _amount);
        campaign.pledged += _amount;
        pledgedAmount[_id][msg.sender] += _amount;
        emit Pledge(_id, msg.sender, _amount);
    }

    // Function to unpledge tokens from a campaign
    function unpledge(uint _id, uint _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(campaign.endAt >= block.timestamp, "ended");
        require(pledgedAmount[_id][msg.sender] >= _amount, "too much");

        campaign.pledged -= _amount;
        pledgedAmount[_id][msg.sender] -= _amount;
        token.transfer(msg.sender, _amount);
        emit Unpledge(_id, msg.sender, _amount);
    }

    // Function for the campaign creator to claim tokens if the goal is reached
    function claim(uint _id) external {
        Campaign storage campaign = campaigns[_id];
        require(msg.sender == campaign.creator, "creator only");
        require(campaign.endAt < block.timestamp, "not ended");
        require(campaign.pledged >= campaign.goal, "campaign failed");
        require(!campaign.claimed, "claimed");

        campaign.claimed = true;
        token.transfer(campaign.creator, campaign.pledged);
        emit Claim(_id);
    }

    // Function for pledgers to get a refund if the campaign fails
    function refund(uint _id) external {
        Campaign storage campaign = campaigns[_id];
        require(campaign.endAt < block.timestamp, "not ended");
        require(campaign.pledged < campaign.goal, "campaign success");

        uint amount = pledgedAmount[_id][msg.sender];
        campaign.pledged -= amount;
        delete pledgedAmount[_id][msg.sender];
        token.transfer(msg.sender, amount);
        emit Refund(_id, msg.sender, amount);
    }
}