pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

/// [Note]: @openzeppelin/contracts v2.5.1
import { IERC20 } from '@openzeppelin/contracts/token/ERC20/IERC20.sol';


/***
 * @notice - Users can stake Uniswap/Balancer LP tokens in return for additional wNXM rewards .
 *         - LP tokens are staked into this Pool contract.
 *         - Staked LP tokens must be only high quality tokens such as ETH/DAI, ETH/USDC, etc...
 **/
contract PoolForStakingLPToken {

    IERC20 public uni_ETH_DAI;
    IERC20 public uni_ETH_USDC;

    constructor(IERC20 _uni_ETH_DAI, IERC20 _uni_ETH_USDC) public {
        uni_ETH_DAI = _uni_ETH_DAI;
        uni_ETH_USDC = _uni_ETH_USDC;
    }


    /***
     * @notice - Users stake Uniswap/Balancer LP tokens into the pool
     **/
    function stakeLPTokens(IERC20 lpToken) public returns (bool) {}    

}
