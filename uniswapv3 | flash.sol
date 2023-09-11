
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./IERC20.sol";
import "./IUniswapV3Pool.sol";
import "./PoolAddress.sol";

contract UniswapV3Flash {
    // Define the Uniswap V3 factory contract address
    address private constant FACTORY =
        0x1F98431c8aD98523631AE4a59f267346ea31F984;

    // Define the addresses for DAI and WETH tokens
    address private constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    // Create an instance of the WETH ERC20 token contract
    IERC20 private constant weth = IERC20(WETH);

    // Define the pool fee (3000 represents a 0.3% fee)
    uint24 private constant POOL_FEE = 3000;

    // Define a struct to store flash data
    struct FlashData {
        uint wethAmount; // Amount of WETH to flash
        address caller;  // Address of the caller
    }

    // Create an immutable instance of the Uniswap V3 pool
    IUniswapV3Pool private immutable pool;

    constructor() {
        // Compute the pool key and get the pool address using the Uniswap V3 PoolAddress library
        PoolAddress.PoolKey memory poolKey = PoolAddress.getPoolKey(DAI, WETH, POOL_FEE);
        pool = IUniswapV3Pool(PoolAddress.computeAddress(FACTORY, poolKey));
    }

    // Function to initiate a flash loan
    function flash(uint wethAmount) external {
        // Encode flash data into bytes
        bytes memory data = abi.encode(
            FlashData({wethAmount: wethAmount, caller: msg.sender})
        );
        
        // Initiate a flash loan from the Uniswap V3 pool
        pool.flash(address(this), 0, wethAmount, data);
    }

    // Callback function called by the Uniswap V3 pool after the flash loan
    function uniswapV3FlashCallback(
        uint fee0,
        uint fee1,
        bytes calldata data
    ) external {
        // Ensure that the caller is the Uniswap V3 pool
        require(msg.sender == address(pool), "not authorized");
        
        // Decode the flash data
        FlashData memory decoded = abi.decode(data, (FlashData));
        
        // Transfer fee1 (usually DAI) from the flash loan back to the caller
        weth.transferFrom(decoded.caller, address(this), fee1);
        
        // Transfer the total amount (flash loan amount + fee1) back to the Uniswap V3 pool
        weth.transfer(msg.sender, decoded.wethAmount + fee1);
    }
}
/*
This Solidity contract facilitates flash loans using the Uniswap V3 pool for swapping WETH and DAI tokens. Here's how it works:

1. The contract initializes by computing the Uniswap V3 pool address for the DAI/WETH trading pair with a specified fee using the `PoolAddress` library. The computed pool address is stored in an immutable variable.

2. Users can initiate flash loans by calling the `flash` function, specifying the amount of WETH they want to borrow.

3. Inside the `flash` function, flash loan data is encoded into bytes and passed to the `pool.flash` function. This initiates the flash loan.

4. After the flash loan is executed, the Uniswap V3 pool calls the `uniswapV3FlashCallback` function to return the borrowed amount plus fees.

5. In the `uniswapV3FlashCallback` function, it first verifies that the caller is the Uniswap V3 pool to prevent unauthorized access.

6. It then decodes the flash data to retrieve the original caller's address and the flash loan amount.

7. The function transfers the fee1 (usually DAI) back to the original caller from the flash loan.

8. Finally, it transfers the total amount (flash loan amount + fee1) back to the Uniswap V3 pool, effectively repaying the flash loan.

This contract allows users to perform flash loans, borrowing WETH from the Uniswap V3 pool and returning it with a fee.
*/