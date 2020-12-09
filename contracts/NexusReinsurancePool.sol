pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

/// [Note]: @openzeppelin/contracts v2.5.1
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";

import { IwNXM } from "./IwNXM.sol";
import { IUniswapV2Pair } from './uniswap/interfaces/IUniswapV2Pair.sol';

/***
 * @notice - Users can stake Uniswap/Balancer LP tokens in return for additional wNXM rewards .
 *         - LP tokens are staked into this Pool contract.
 *         - Staked LP tokens must be only high quality tokens such as ETH/DAI, ETH/USDC, etc...
 *
 * @notice - Deployed as per settings delivered by the Reinsurance Pool Manager Contract
 *         - Each ReinsurancePool has a contract address
 *         - Liquidity providers lock-up LP tokens as per the lock structure.
 *         - LP’s get wNXM rewards as per the reward structure. 
 *         - X wNXM streamed per block split proportionally between all LP’s that aren’t in the un-lock period.
 **/
contract NexusReinsurancePool {
    using SafeMath for uint;

    IwNXM public wNXMToken;

    uint256 lockuUpPeriodOfLpToken = 90 days; /// [Note]: Lock up period of LP tokens. Default period is 90 days
    uint8 defaultMCRRate = 90;  /// [Note]: 90%
    uint8 currentMCRRate;       /// [Todo]: Retrieve current MCR rate

    address payable NEXUS_REINSURANCE_POOL_MANAGER;
    address UNI_ETH_DAI;
    address UNI_ETH_USDC;

    constructor(address payable _nexusReinsurancePoolManager, IwNXM _wNXMToken, IUniswapV2Pair _uni_ETH_DAI, IUniswapV2Pair _uni_ETH_USDC) public {
        NEXUS_REINSURANCE_POOL_MANAGER = _nexusReinsurancePoolManager;
        wNXMToken = _wNXMToken;

        UNI_ETH_DAI = address(_uni_ETH_DAI);
        UNI_ETH_USDC = address(_uni_ETH_USDC);
    }


    /***
     * @notice - Users stake Uniswap's LP tokens into the pool
     * @param lpToken - Staked LP tokens must be only high quality tokens such as ETH/DAI, ETH/USDC, etc...
     **/
    function stakeUniswapLPToken(IUniswapV2Pair lpToken, uint stakingAmount) public returns (bool) {
        require (address(lpToken) == UNI_ETH_DAI || address(lpToken) == UNI_ETH_USDC, "Staked Uniswap's LP tokens must be ETH/DAI or ETH/USDC");
        require(lpToken.transferFrom(msg.sender, address(this), stakingAmount), "Uniswap's LP tokens: transferFrom failed");
    }


    /***
     * @notice - Generate rewards (wNXM) for stakers (staked users).
     *         - When MCR % exceed threshold, generated reward will be distributed into stakers.
     **/
    function generateReward(address staker) public returns (bool) {
        /// Generate reward (wNXM)
        uint rewardAmount;

        /// Distribute reward when MCR % exceed threshold,
        /// [Todo]: Condition is needed to be fixed.
        if (claimForTakingLPToken() == true) {
            _distributeReward(staker, rewardAmount);
        }
    }

    function _distributeReward(address staker, uint rewardAmount) internal returns (bool) {
        wNXMToken.transfer(staker, rewardAmount);
    }


    /***
     * @notice - Claim triggers are defined if MCR% drops below a certain threshold (90%), then transfer LP tokens worth 10% of MCR's ETH into NexusReinsurancePoolManager
     **/
    function claimForTakingLPToken() public returns (bool) {
        if (currentMCRRate < defaultMCRRate) {
            /// Compute transferred LP tokens worth 10% of MCR's ETH
            uint8 withdrawnPercentage = 100 - currentMCRRate;
            uint MCREth;

            /// Transfer LP tokens into the NexusReinsurancePoolManager contract
            uint amount = MCREth.mul(uint256(withdrawnPercentage)).div(100);
            NEXUS_REINSURANCE_POOL_MANAGER.transfer(amount);
        }
    }
    



    ///------------------------------------------------------------
    /// Internal functions
    ///------------------------------------------------------------



    ///------------------------------------------------------------
    /// Getter functions
    ///------------------------------------------------------------
 


    ///------------------------------------------------------------
    /// Private functions
    ///------------------------------------------------------------

}
