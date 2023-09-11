// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./IERC20.sol";

contract StakingRewards {
    // Immutable references to staking and rewards tokens
    IERC20 public immutable stakingToken;
    IERC20 public immutable rewardsToken;

    // Address of the contract owner
    address public owner;

    // Duration of rewards to be paid out (in seconds)
    uint public duration;
    // Timestamp of when the rewards finish
    uint public finishAt;
    // Minimum of last updated time and reward finish time
    uint public updatedAt;
    // Reward to be paid out per second
    uint public rewardRate;
    // Sum of (reward rate * dt * 1e18 / total supply)
    uint public rewardPerTokenStored;
    // User address => rewardPerTokenStored
    mapping(address => uint) public userRewardPerTokenPaid;
    // User address => rewards to be claimed
    mapping(address => uint) public rewards;

    // Total staked
    uint public totalSupply;
    // User address => staked amount
    mapping(address => uint) public balanceOf;

    constructor(address _stakingToken, address _rewardsToken) {
        owner = msg.sender;
        stakingToken = IERC20(_stakingToken);
        rewardsToken = IERC20(_rewardsToken);
    }

    // Modifier to restrict certain functions to the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "not authorized");
        _;
    }

    // Modifier to update rewards when interacting with the contract
    modifier updateReward(address _account) {
        rewardPerTokenStored = rewardPerToken();
        updatedAt = lastTimeRewardApplicable();
        if (_account != address(0)) {
            rewards[_account] = earned(_account);
            userRewardPerTokenPaid[_account] = rewardPerTokenStored;
        }
        _;
    }

    // Function to calculate the last time rewards were applicable
    function lastTimeRewardApplicable() public view returns (uint) {
        return _min(block.timestamp, finishAt);
    }

    // Function to calculate the reward rate per token
    function rewardPerToken() public view returns (uint) {
        if (totalSupply == 0) {
            return rewardPerTokenStored;
        } else {
            uint _duration = lastTimeRewardApplicable() - updatedAt;
            return rewardPerTokenStored + rewardRate * _duration * 1e18 / totalSupply;
        }
    }

    // Function to stake tokens and receive rewards
    function stake(uint _amount) external updateReward(msg.sender) {
        require(_amount > 0, "amount = 0");
        stakingToken.transferFrom(msg.sender, address(this), _amount);
        balanceOf[msg.sender] += _amount;
        totalSupply += _amount;
    }

    // Function to withdraw tokens and update rewards
    function withdraw(uint _amount) external updateReward(msg.sender) {
        require(_amount > 0, "amount = 0");
        balanceOf[msg.sender] -= _amount;
        totalSupply -= _amount;
        stakingToken.transfer(msg.sender, _amount);
    }

    // Function to calculate the earned rewards for a user
    function earned(address _account) public view returns (uint) {
        return
        ((balanceOf[_account] *
            (rewardPerToken() - userRewardPerTokenPaid[_account])) / 1e18) +
        rewards[_account];
    }

    // Function to allow users to claim their rewards
    function getReward() external updateReward(msg.sender) {
        uint reward = rewards[msg.sender];
        if (reward > 0) {
            rewards[msg.sender] = 0;
            rewardsToken.transfer(msg.sender, reward);
        }
    }

    // Function to set the rewards duration (only by the owner)
    function setRewardsDuration(uint _duration) external onlyOwner {
        require(block.timestamp > finishAt, "block.timestamp <= finishAt");
        duration = _duration;
    }

    // Function to notify the contract of the reward amount (only by the owner)
    function notifyRewardAmount(uint _amount) external onlyOwner updateReward(address(0)) {
        if (block.timestamp >= finishAt) {
            rewardRate = _amount / duration;
        } else {
            uint remainingRewards = (finishAt - block.timestamp) * rewardRate;
            rewardRate = (_amount + remainingRewards) / duration;
        }
        require(rewardRate > 0, "rewardRate should be greater than 0");
        require(
            rewardRate * duration <= rewardsToken.balanceOf(address(this)),
            "reward amount > balance"
        );
        
        finishAt = block.timestamp + duration;
        updatedAt = block.timestamp;
    }

    // Internal function to return the minimum of two numbers
    function _min(uint x, uint y) private pure returns (uint) {
        return x <= y ? x : y;
    }
}

/*
Here's a step-by-step explanation of the code:

1. The contract starts with SPDX license information and specifies the Solidity version.

2. It imports an interface `IERC20.sol`, which likely represents the ERC-20 token standard.

3. The `StakingRewards` contract is defined with state variables, including two immutable ERC20 tokens (`stakingToken` and `rewardsToken`), an `owner` address, and various variables related to rewards, staking, and accounting.

4. The constructor initializes the contract with the addresses of the staking token and rewards token. The `owner` is set to the address of the contract creator (`msg.sender`).

5. The contract includes a modifier `onlyOwner()` to restrict certain functions to the contract owner.

6. It also includes a modifier `updateReward(address _account)` used to update rewards when interacting with the contract.

7. Several functions are defined to calculate rewards and interact with the staking mechanism. These functions include `lastTimeRewardApplicable()`, `rewardPerToken()`, `stake()`, `withdraw()`, `earned()`, and `getReward()`.

8. The `setRewardsDuration()` function allows the contract owner to set the duration of rewards.

9. The `notifyRewardAmount()` function allows the contract owner to notify the contract of the reward amount to be distributed.

10. An internal `_min()` function is used to return the minimum of two numbers.

This contract appears to implement a staking rewards system, where users can stake tokens, earn rewards, and claim those rewards. The contract owner can configure reward parameters and notify the contract of reward amounts. Users' rewards are updated whenever they interact with the contract.

If you have further questions or need additional explanations, please feel free to ask.
*/