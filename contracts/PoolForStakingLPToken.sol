pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

/// [Note]: @openzeppelin/contracts v2.5.1
//import { IERC20 } from '@openzeppelin/contracts/token/ERC20/IERC20.sol';

import { IUniswapV2Pair } from './uniswap/interfaces/IUniswapV2Pair.sol';


/***
 * @notice - Users can stake Uniswap/Balancer LP tokens in return for additional wNXM rewards .
 *         - LP tokens are staked into this Pool contract.
 *         - Staked LP tokens must be only high quality tokens such as ETH/DAI, ETH/USDC, etc...
 **/
contract PoolForStakingLPToken {

    IUniswapV2Pair public uni_ETH_DAI;
    IUniswapV2Pair public uni_ETH_USDC;

    constructor(IUniswapV2Pair _uni_ETH_DAI, IUniswapV2Pair _uni_ETH_USDC) public {
        uni_ETH_DAI = _uni_ETH_DAI;
        uni_ETH_USDC = _uni_ETH_USDC;
    }


    /***
     * @notice - Users stake Uniswap/Balancer LP tokens into the pool
     * @param lpToken - Staked LP tokens must be only high quality tokens such as ETH/DAI, ETH/USDC, etc...
     **/
    function stakeLPTokens(IUniswapV2Pair lpToken, uint stakingAmount) public returns (bool) {
        require(lpToken.transferFrom(msg.sender, address(this), stakingAmount), "Uniswap LP token: transferFrom failed");
    }    

}
