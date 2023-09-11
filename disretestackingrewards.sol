// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./IERC20.sol";

contract DiscreteStakingRewards {
    IERC20 public immutable stakingToken;
    IERC20 public immutable rewardToken;

    // Declare state variables for storing the amounts of tokens staked
    mapping(address => uint) public balanceOf;
    uint public totalSupply;

    // Declare state variables for calculating rewards
    // A state variable to store the sum of reward amounts / total staked
    uint private rewardIndex;
    // Mapping that stores the current rewardIndex per staker when the staker either stakes, unstakes, or claims rewards.
    mapping(address => uint) private rewardIndexOf;
    // Mapping that stores the amount of rewards earned for each staker
    mapping(address => uint) private earned;
    // A number multiplied with reward amounts.
    // This is used to prevent divisions from rounding down to 0.
    uint private constant MULTIPLIER = 1e18;

    constructor(address _stakingToken, address _rewardToken) {
        stakingToken = IERC20(_stakingToken);
        rewardToken = IERC20(_rewardToken);
    }

    // Function to update the reward index when rewards are added to the contract
    function updateRewardIndex(uint reward) external {
        // Transfer the reward tokens from the sender to the contract
        rewardToken.transferFrom(msg.sender, address(this), reward);
        // Update the rewardIndex by adding the scaled reward to it
        rewardIndex += (reward * MULTIPLIER) / totalSupply;
    }

    // Function to calculate rewards earned by an account
    function _calculateRewards(address account) private view returns (uint) {
        // Calculate the rewards earned by the account based on their balance and the reward index
        return balanceOf[account] * (rewardIndex - rewardIndexOf[account]) / MULTIPLIER;
    }

    // Function to calculate total rewards earned by an account
    function calculateRewardsEarned(address account) external view returns (uint) {
        // Calculate total rewards earned by the account by summing up earned rewards and pending rewards
        return earned[account] + _calculateRewards(account);
    }

    // Function to update rewards for an account
    function _updateRewards(address account) private {
        // Calculate pending rewards and add them to the earned rewards for the account
        earned[account] += _calculateRewards(msg.sender);
        // Update the rewardIndexOf the account to the current rewardIndex
        rewardIndexOf[account] = rewardIndex;
    }

    // Function to stake tokens
    function stake(uint amount) external {
        // Update rewards for the sender
        _updateRewards(msg.sender);
        // Increase the balance and totalSupply
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        // Transfer staked tokens from the sender to the contract
        stakingToken.transferFrom(msg.sender, address(this), amount);
    }

    // Function to unstake tokens
    function unstake(uint amount) external {
        // Update rewards for the sender
        _updateRewards(msg.sender);
        // Decrease the balance and totalSupply
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        // Transfer unstaked tokens from the contract to the sender
        stakingToken.transfer(msg.sender, amount);
    }

    // Function to claim earned rewards
    function claim() external returns (uint) {
        // Update rewards for the sender
        _updateRewards(msg.sender);
        // Get the earned reward for the sender
        uint reward = earned[msg.sender];
        if (reward > 0) {
            // Reset the earned rewards for the sender
            earned[msg.sender] = 0;
            // Transfer the earned reward tokens to the sender
            rewardToken.transfer(msg.sender, reward);
        }
        return reward;
    }
}
/*
Here's an explanation of each part of the code:

1. The contract begins with SPDX license information and specifies the Solidity version.

2. The contract is named `DiscreteStakingRewards` and is designed for staking and rewarding users with tokens.

3. It imports the `IERC20` interface, assuming that it represents a standard ERC20 token.

4. Two immutable state variables are declared: `stakingToken` and `rewardToken`, which represent the tokens users stake and receive as rewards.

5. The contract maintains the balance of staked tokens for each user using the `balanceOf` mapping, and the total staked supply is tracked with the `totalSupply` state variable.

6. To calculate rewards, the contract uses several state variables and mappings:
   - `rewardIndex`: This state variable stores the sum of reward amounts divided by the total supply.
   - `rewardIndexOf`: This mapping stores the current rewardIndex per staker to track when they last interacted with the contract.
   - `earned`: This mapping stores the amount of rewards earned by each staker.
   - `MULTIPLIER`: A constant multiplier to prevent rounding errors in reward calculations.

7. The constructor initializes the `stakingToken` and `rewardToken` state variables based on the provided addresses.

8. The `updateRewardIndex` function allows users to update the reward index by transferring reward tokens to the contract. This is typically done when rewards are added to the contract.

9. The `_calculateRewards` function calculates the rewards earned by an account based on their balance and the current reward index.

10. The `calculateRewardsEarned` function allows users to view the total rewards earned by their account, including both earned and pending rewards.

11. The `_updateRewards` function updates the rewards for an account by calculating and adding pending rewards to the earned rewards. It also updates the `rewardIndexOf` to the current `rewardIndex`.

12. The `

stake` function allows users to stake tokens. It updates rewards, increases the user's balance, and updates the total supply. It also transfers staked tokens from the user to the contract.

13. The `unstake` function allows users to unstake tokens. It updates rewards, decreases the user's balance, and updates the total supply. It transfers unstaked tokens from the contract to the user.

14. The `claim` function allows users to claim their earned rewards. It updates rewards, retrieves the earned reward amount, resets the earned rewards to zero, and transfers the earned reward tokens to the user.

This contract is a basic implementation of a staking and reward distribution system, where users can stake tokens, earn rewards, and claim their rewards when needed. The rewards are calculated based on the staked amount and the duration of staking. Users can interact with the contract to stake, unstake, and claim rewards as per their requirements.
*/