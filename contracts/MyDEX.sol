// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MyDEX {
    address public token1;
    address public token2;
    uint public reserve1;
    uint public reserve2;

    constructor(address _token1, address _token2) {
        token1 = _token1;
        token2 = _token2;
    }

    // Add liquidity to the pool
    function addLiquidity(uint amount1, uint amount2) public {
        IERC20(token1).transferFrom(msg.sender, address(this), amount1);
        IERC20(token2).transferFrom(msg.sender, address(this), amount2);
        reserve1 += amount1;
        reserve2 += amount2;
    }

    // Swap function using constant product formula (minimal, no fees!)
    function swap(address tokenIn, uint amountIn, address tokenOut, uint amountOutMin) public {
        require(tokenIn == token1 || tokenIn == token2, "Invalid tokenIn");
        require(tokenOut == token1 || tokenOut == token2, "Invalid tokenOut");
        require(tokenIn != tokenOut, "Cannot swap same token");

        uint reserveIn = tokenIn == token1 ? reserve1 : reserve2;
        uint reserveOut = tokenOut == token1 ? reserve1 : reserve2;

        // Calculate output using constant product (x * y = k)
        uint amountOut = getAmountOut(amountIn, reserveIn, reserveOut);
        require(amountOut >= amountOutMin, "Slippage too high");

        IERC20(tokenIn).transferFrom(msg.sender, address(this), amountIn);
        IERC20(tokenOut).transfer(msg.sender, amountOut);

        if (tokenIn == token1) reserve1 += amountIn;
        else reserve2 += amountIn;
        if (tokenOut == token1) reserve1 -= amountOut;
        else reserve2 -= amountOut;
    }

    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) public pure returns (uint) {
        // Simple constant product (with no fees, for demo only)
        uint product = reserveIn * reserveOut;
        return reserveOut - (product / (reserveIn + amountIn));
    }
}
