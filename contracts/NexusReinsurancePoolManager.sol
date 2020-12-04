pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

import { MainStorage } from  "./mainStorage/MainStorage.sol";

import { IPooledStaking } from "./nexus-mutual/interfaces/IPooledStaking.sol";
import { ITokenData } from "./nexus-mutual/interfaces/ITokenData.sol";

import { MCR } from "./nexus-mutual/modules/capital//MCR.sol";
import { INXMToken } from "./nexus-mutual/abstract/INXMToken.sol";
import { Claims } from "./nexus-mutual/modules/claims/Claims.sol";

import { IwNXM } from "./IwNXM.sol";
import { NexusReinsurancePoolFactory } from "./NexusReinsurancePoolFactory.sol";
import { NexusMutualCapitalPool } from "./NexusMutualCapitalPool.sol";


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
    INXMToken public nxmToken;
    IPooledStaking public pooledStaking;
    ITokenData public tokenData;
    Claims public claims;
    IwNXM public wNXMToken;
    NexusReinsurancePoolFactory public nexusReinsurancePoolFactory;
    NexusMutualCapitalPool public nexusMutualCapitalPool;

    address MCR_ADDRESS;
    address NXM_TOKEN; 
    address POOLED_STAKING;
    address CLAIMS; 
    address WNXM_TOKEN;
    address NEXUS_REINSURANCE_POOL_FACTORY;
    address NEXUS_MUTUAL_CAPITAL_POOL;

    constructor(MainStorage _mainStorage, MCR _mcr, INXMToken _nxmToken, IPooledStaking _pooledStaking, ITokenData _tokenData, Claims _claims, IwNXM _wNXMToken, NexusMutualCapitalPool _nexusMutualCapitalPool, NexusReinsurancePoolFactory _nexusReinsurancePoolFactory) public {
        mainStorage = _mainStorage;

        pooledStaking = _pooledStaking;
        tokenData = _tokenData;

        mcr = _mcr;
        nxmToken = _nxmToken;
        claims = _claims;
        wNXMToken = _wNXMToken;
        nexusReinsurancePoolFactory = _nexusReinsurancePoolFactory;
        nexusMutualCapitalPool = _nexusMutualCapitalPool;

        MCR_ADDRESS = address(_mcr);
        NXM_TOKEN = address(_nxmToken);
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
    function createNexusReinsurancePool(uint nxmAmount) public returns (bool) {
        /// Receives NXM from the Nexus Mutual Capital Pool
        nexusMutualCapitalPool.provideNXMReward(address(this), nxmAmount);

        /// Convert received NXM to wNXM
        convertFromNXMToWNXM(nxmAmount);

        /// Create a new reinsurance pool
        address newNexusReinsurancePool = nexusReinsurancePoolFactory.createNexusReinsurancePool();

        /// Send wNXM as rewards into a new reinsurance pool
        uint rewardsAmount = wNXMToken.balanceOf(address(this));
        sendWNXMRewardToReinsurancePool(newNexusReinsurancePool, rewardsAmount);
    }


    ///------------------------------------------------------------
    /// Functions that are used when rewards
    ///------------------------------------------------------------

    /***
     * @notice - Converts NXM to wNXM. After that, loads up rewards
     **/
    function convertFromNXMToWNXM(uint nxmAmount) public returns (bool) {    
        /// Converts from NXM to wNXM
        _convertFromNXMToWNXM(nxmAmount);

        /// Loads up rewards
    }

    /***
     * @notice - Sends wNXM rewards to the Reinsurance pools.
     **/
    function sendWNXMRewardToReinsurancePool(address reinsurancePool, uint rewardsAmount) public returns (bool) {
        wNXMToken.transfer(reinsurancePool, rewardsAmount);
    }    


    ///------------------------------------------------------------
    /// Functions that are used when claims
    ///------------------------------------------------------------

    /***
     * @notice - Receives LP tokens in the event of a claim
     **/
    function receiveLPToken() public returns (bool) {}
    

    /***
     * @notice - Converts (Redeem) LP tokens into underlying assets
     **/
    function convertLPTokenIntoUnderlyingAsset() public returns (bool) {}


    /***
     * @notice - Sends underlying assets into Nexus Mutual capital pool
     **/ 
    function sendUnderlyingAssetIntoNexusMutualCapitalPool() public returns (bool) {}



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
    /// Internal functions
    ///------------------------------------------------------------
    
    function _convertFromNXMToWNXM(uint receivedNXMAmount) internal returns (bool) {
        /// Mint WNXM token (and send those tokens into this contract)
        wNXMToken.wrap(receivedNXMAmount);
    }





    ///------------------------------------------------------------
    /// Getter functions
    ///------------------------------------------------------------
 


    ///------------------------------------------------------------
    /// Private functions
    ///------------------------------------------------------------


}
