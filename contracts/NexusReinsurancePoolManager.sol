pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

import { MainStorage } from  "./mainStorage/MainStorage.sol";

import { IPooledStaking } from "./nexus-mutual/interfaces/IPooledStaking.sol";
import { ITokenData } from "./nexus-mutual/interfaces/ITokenData.sol";

import { MCR } from "./nexus-mutual/modules/capital//MCR.sol";
import { INXMToken } from "./nexus-mutual/abstract/INXMToken.sol";
import { Claims } from "./nexus-mutual/modules/claims/Claims.sol";

import { IwNXM } from "./IwNXM.sol";
import { NexusReinsurancePool } from "./NexusReinsurancePool.sol";
import { NexusReinsurancePoolFactory } from "./NexusReinsurancePoolFactory.sol";
import { NexusMutualCapitalPool } from "./NexusMutualCapitalPool.sol";

import { IUniswapV2Pair } from './uniswap/interfaces/IUniswapV2Pair.sol';
import { IUniswapV2Router02 } from './uniswap/interfaces/IUniswapV2Router02.sol';


/***
 * @notice - The interface between the reinsurance pool and Nexus Mutual.
 *         - Multi-sig governance that can only change items if passed by Nexus Mutual formal governance. 
 *
 * @dev - Note: integrate into full governance later.
 * @dev - TO DO: Define the precise claim triggers that will result in a reinsurance claim and for how much.
 *
 * @dev - Has the power to:
 *        ・Deploy new reinsurance pools with specific parameters
 *        ・Set reward rates per pool
 *        ・Send rewards to the reinsurance pools for distribution
 **/
contract NexusReinsurancePoolManager {
    MainStorage public mainStorage;
    MCR public mcr;
    INXMToken public NXMToken;
    IPooledStaking public pooledStaking;
    ITokenData public tokenData;
    Claims public claims;
    IwNXM public wNXMToken;
    NexusReinsurancePoolFactory public nexusReinsurancePoolFactory;
    NexusMutualCapitalPool public nexusMutualCapitalPool;
    IUniswapV2Router02 public uniswapV2Router02;

    address MCR_ADDRESS;
    address NXM_TOKEN; 
    address POOLED_STAKING;
    address CLAIMS; 
    address WNXM_TOKEN;
    address NEXUS_REINSURANCE_POOL_FACTORY;
    address NEXUS_MUTUAL_CAPITAL_POOL;

    constructor(MainStorage _mainStorage, MCR _mcr, INXMToken _NXMToken, IPooledStaking _pooledStaking, ITokenData _tokenData, Claims _claims, IwNXM _wNXMToken, NexusMutualCapitalPool _nexusMutualCapitalPool, NexusReinsurancePoolFactory _nexusReinsurancePoolFactory, IUniswapV2Router02 _uniswapV2Router02) public {
        mainStorage = _mainStorage;
        pooledStaking = _pooledStaking;
        tokenData = _tokenData;
        mcr = _mcr;
        NXMToken = _NXMToken;
        claims = _claims;
        wNXMToken = _wNXMToken;
        nexusReinsurancePoolFactory = _nexusReinsurancePoolFactory;
        nexusMutualCapitalPool = _nexusMutualCapitalPool;
        uniswapV2Router02 = _uniswapV2Router02;

        MCR_ADDRESS = address(_mcr);
        NXM_TOKEN = address(_NXMToken);
        POOLED_STAKING = address(_pooledStaking);
        CLAIMS = address(_claims);
        WNXM_TOKEN = address(_wNXMToken);
        NEXUS_REINSURANCE_POOL_FACTORY = address(_nexusReinsurancePoolFactory);
        NEXUS_MUTUAL_CAPITAL_POOL = address(_nexusMutualCapitalPool);
    }


    ///------------------------------------------------------------
    /// Functions that new Nexus Reinsurance Pool creation
    ///------------------------------------------------------------

    /***
     * @notice - Create a new Nexus Reinsurance Pool
     * @param nxmAmount - NXM token amount is specified when this method is executed
     **/
    function createNexusReinsurancePool(uint nxmAmount, uint8 rewardRate) public returns (bool) {
        /// Receives NXM from the Nexus Mutual Capital Pool
        nexusMutualCapitalPool.provideNXMReward(address(this), nxmAmount);

        /// Convert received NXM to wNXM
        _convertFromNXMToWNXM(nxmAmount);

        /// Create a new reinsurance pool
        //address payable NEXUS_REINSURANCE_POOL_MANAGER = address(uint160(address(this)));  /// [Note]: address(uint160()) is a method for converting address to payable
        uint8 newNexusReinsuranceId;
        address newNexusReinsurancePool;

        (newNexusReinsuranceId, newNexusReinsurancePool) = nexusReinsurancePoolFactory.createNexusReinsurancePool(this);

        /// Set reward rate of a new reinsurance pool
        setRewardRate(newNexusReinsuranceId, rewardRate);

        /// Loads up rewards (wNXM tokens) into specified reinsurance pool
        uint rewardsAmount = wNXMToken.balanceOf(address(this));
        _loadUpRewards(newNexusReinsurancePool, rewardsAmount);
    }


    ///------------------------------------------------------------
    /// Configuration related functions of Nexus Mutual
    ///------------------------------------------------------------

    /***
     * @notice - Set reward rates per pool
     **/ 
    function setRewardRate(uint8 reinsurancePoolId, uint8 rewardRate) public returns (bool) {
        mainStorage.saveRewardRate(reinsurancePoolId, rewardRate);
    }


    ///------------------------------------------------------------
    /// Functions that are used when rewards
    ///------------------------------------------------------------



    ///------------------------------------------------------------
    /// Functions that are used when claims
    ///------------------------------------------------------------

    /***
     * @notice - Receives LP tokens in the event of a claim
     * @param nexusReinsurancePool - NexusReinsurancePool that is the target of claim
     * @param claimedLPToken - LPToken that this contract will claim
     **/
    function receiveLPToken(NexusReinsurancePool nexusReinsurancePool, IUniswapV2Pair claimedLPToken) public returns (bool) {
        nexusReinsurancePool.claimForTakingLPToken(claimedLPToken);
    }
    

    /***
     * @notice - Converts (Redeem) LP tokens into underlying assets
     **/
    function convertLPTokenIntoUnderlyingAsset(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) public returns (bool) {
        /// [Todo]: Add method of Uniswap in order to redeem LP tokens with underlying assets (e.g. DAI, ETH, USDC, etc...)
        uint amountA;
        uint amountB;
        (amountA, amountB) = uniswapV2Router02.removeLiquidity(tokenA, 
                                                              tokenB, 
                                                              liquidity,
                                                              amountAMin,
                                                              amountBMin,
                                                              to,
                                                              deadline);
    }


    /***
     * @notice - Sends underlying assets into Nexus Mutual capital pool
     **/ 
    function sendUnderlyingAssetIntoNexusMutualCapitalPool() public returns (bool) {}




    ///------------------------------------------------------------
    /// Internal functions
    ///------------------------------------------------------------

    /***
     * @notice - Converts NXM to wNXM. After that, loads up rewards
     **/
    function _convertFromNXMToWNXM(uint receivedNXMAmount) internal returns (bool) {
        /// Mint WNXM token (and send those tokens into this contract)
        NXMToken.approve(WNXM_TOKEN, receivedNXMAmount);
        wNXMToken.wrap(receivedNXMAmount);
    }

    /***
     * @notice - load up rewards (wNXM tokens) into the Reinsurance pools.
     **/
    function _loadUpRewards(address reinsurancePool, uint rewardsAmount) internal returns (bool) {
        wNXMToken.transfer(reinsurancePool, rewardsAmount);
    }




    ///------------------------------------------------------------
    /// Getter functions
    ///------------------------------------------------------------
 


    ///------------------------------------------------------------
    /// Private functions
    ///------------------------------------------------------------


}
