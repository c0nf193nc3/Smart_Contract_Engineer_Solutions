
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./IERC20.sol";
import "./IERC721Receiver.sol";
import "./INonfungiblePositionManager.sol";

contract UniswapV3Liquidity is IERC721Receiver {
    // Define constants for the DAI and WETH token addresses
    address private constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    // Create instances of the ERC20 token contracts for DAI and WETH
    IERC20 private constant dai = IERC20(DAI);
    IERC20 private constant weth = IERC20(WETH);

    // Define constant values for tick range management
    int24 private constant MIN_TICK = -887272;
    int24 private constant MAX_TICK = -MIN_TICK;
    int24 private constant TICK_SPACING = 60;

    // Create an instance of the Uniswap V3 Nonfungible Position Manager
    INonfungiblePositionManager public manager =
        INonfungiblePositionManager(0xC36442b4a4522E871399CD717aBDD847Ab11FE88);

    event Mint(uint tokenId);

    function onERC721Received(
        address operator,
        address from,
        uint tokenId,
        bytes calldata
    ) external returns (bytes4) {
        // Code here (This function allows the contract to receive NFTs)
        return IERC721Receiver.onERC721Received.selector;
    }

    // Mint a new position by adding liquidity
    function mint(uint amount0ToAdd, uint amount1ToAdd) external {
        // Transfer the specified amounts of DAI and WETH from the caller to this contract
        dai.transferFrom(msg.sender, address(this), amount0ToAdd);
        weth.transferFrom(msg.sender, address(this), amount1ToAdd);

        // Approve the Nonfungible Position Manager to spend the transferred tokens
        dai.approve(address(manager), amount0ToAdd);
        weth.approve(address(manager), amount1ToAdd);

        // Define the tick range for the position
        int24 tickLower = (MIN_TICK / TICK_SPACING) * TICK_SPACING;
        int24 tickUpper = (MAX_TICK / TICK_SPACING) * TICK_SPACING;

        // Create parameters for minting a new position
        INonfungiblePositionManager.MintParams memory params = INonfungiblePositionManager.MintParams(
            DAI, WETH, 3000, tickLower, tickUpper, amount0ToAdd, amount1ToAdd,
            0, 0, address(this), block.timestamp);

        // Perform the mint operation and receive the position details
        (uint tokenId, uint128 liquidity, uint amount0, uint amount1) = manager.mint(params);

        // Refund any unused tokens back to the caller
        if (amount0ToAdd > amount0) {
            dai.transfer(msg.sender, amount0ToAdd - amount0);
        }
        if (amount1ToAdd > amount1) {
            weth.transfer(msg.sender, amount1ToAdd - amount1);
        }

        // Clear token approvals after the operation
        dai.approve(address(manager), 0);
        weth.approve(address(manager), 0);

        // Emit an event to indicate the successful minting of the position
        emit Mint(tokenId);
    }

    // Increase liquidity for an existing position
    function increaseLiquidity(
        uint tokenId,
        uint amount0ToAdd,
        uint amount1ToAdd
    ) external {
        // Transfer the specified amounts of DAI and WETH from the caller to this contract
        dai.transferFrom(msg.sender, address(this), amount0ToAdd);
        weth.transferFrom(msg.sender, address(this), amount1ToAdd);

        // Approve the Nonfungible Position Manager to spend the transferred tokens
        dai.approve(address(manager), amount0ToAdd);
        weth.approve(address(manager), amount1ToAdd);

        // Create parameters for increasing liquidity for an existing position
        INonfungiblePositionManager.IncreaseLiquidityParams memory params =
            INonfungiblePositionManager.IncreaseLiquidityParams(
                tokenId, amount0ToAdd, amount1ToAdd, 0, 0, block.timestamp);

        // Perform the liquidity increase operation and receive updated liquidity and token amounts
        (uint128 liquidity, uint amount0, uint amount1) = manager.increaseLiquidity(params);

        // Refund any unused tokens back to the caller
        if (amount0ToAdd > amount0) {
            dai.transfer(msg.sender, amount0ToAdd - amount0);
        }
        if (amount1ToAdd > amount1) {
            weth.transfer(msg.sender, amount1ToAdd - amount1);
        }

        // Clear token approvals after the operation
        dai.approve(address(manager), 0);
        weth.approve(address(manager), 0);
    }

    // Decrease liquidity for an existing position
    function decreaseLiquidity(uint tokenId, uint128 liquidity) external {
        // Create parameters for decreasing liquidity for an existing position
        INonfungiblePositionManager.DecreaseLiquidityParams memory params =
            INonfungiblePositionManager.DecreaseLiquidityParams(
                tokenId, liquidity, 0, 0, block.timestamp);

        // Perform the liquidity decrease operation
        manager.decreaseLiquidity(params);
    }

    // Collect fees and tokens for an existing position
    function collect(uint tokenId) external {
        // Create parameters for collecting fees and tokens for an existing position
        INonfungiblePositionManager.CollectParams memory params =
            INonfungiblePositionManager.CollectParams(
                tokenId, msg.sender, type(uint128).max, type(uint128).max);

        // Perform the collect operation
        manager.collect(params);
    }
}

/*
This Solidity contract interacts with Uniswap V3's Nonfungible Position Manager to allow users to manage liquidity positions. It provides the following functions:

1. `onERC721Received`: This function is part of the `IERC721Receiver` interface and allows the contract to receive NFTs (liquidity positions).

2. `mint`: Allows users to create a new liquidity position by adding DAI and WETH tokens. Users specify the amounts of DAI and WETH they want to add to the position, and the contract performs the minting operation.

3. `increaseLiquidity`: Allows users to increase the liquidity of an existing position by adding more DAI and WETH tokens to it.

4. `decreaseLiquidity`: Allows users to decrease the liquidity of an existing position by providing the position ID and the amount of liquidity to remove.

5. `collect`: Allows users to collect fees and tokens earned from an existing liquidity position.

The contract transfers tokens from the caller to itself, approves the Nonfungible Position Manager to spend these tokens, performs the specified operation (e.g., minting, increasing liquidity), refunds any unused tokens back to the caller, and clears token approvals after each operation. Events are emitted to indicate the successful minting of of a position (Mint).

*/