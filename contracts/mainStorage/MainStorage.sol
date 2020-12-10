pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

/// [Note]: @openzeppelin/contracts v2.5.1
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";

import { MainStorages } from "./commons/MainStorages.sol";
import { IUniswapV2Pair } from '../uniswap/interfaces/IUniswapV2Pair.sol';


/***
 * @notice - This contract is for saving methods into the main structs (which are defined in the CommonObjects.sol)
 **/
contract MainStorage is MainStorages {
    using SafeMath for uint;

    uint8 public currentStakerId;           /// Staker ID
    uint8 public currentReinsurancePoolId;  /// Reinsurance Pool ID
    uint8 public currentClaimId;            /// Claim ID

    constructor() public {}


    /***
     * @notice - Save a reinsurance pool's data
     **/ 
    function saveStakerData(address stakerAddress, IUniswapV2Pair lpToken, uint stakedAmount, uint stakedTimestamp) public returns (uint8 _newStakerId) {
        uint8 newStakerId = getNextStakerId();
        currentStakerId++;

        Staker storage staker = stakers[newStakerId];  /// Key: stakerId
        staker.stakerAddress = stakerAddress;
        staker.stakedLPToken = lpToken;
        staker.stakedAmount = stakedAmount;
        staker.stakedTimestamp = stakedTimestamp;
    
        return newStakerId;
    }

    /***
     * @notice - Save a reinsurance pool's data
     **/ 
    function saveReinsurancePool(address reinsurancePoolAddress) public returns (uint8 _newReinsurancePoolId) {
        uint8 newReinsurancePoolId = getNextReinsurancePoolId();
        currentReinsurancePoolId++;

        ReinsurancePool storage reinsurancePool = reinsurancePools[newReinsurancePoolId];  /// Key: reinsurancePoolId
        reinsurancePool.reinsurancePoolAddress = reinsurancePoolAddress;
    
        return newReinsurancePoolId;
    }

    /***
     * @notice - Save a claim data
     * @dev - Claimer is only ReinsurancePoolManager contract
     **/ 
    function saveClaimData(IUniswapV2Pair claimedLPToken, uint claimedLPTokenAmount) public returns (uint8 _newClaimId) {
        uint8 newClaimId = getNextClaimId();
        currentClaimId++;

        Claim storage claim = claims[newClaimId];  /// Key: claimId
        claim.claimedLPToken = claimedLPToken;
        claim.claimedLPTokenAmount = claimedLPTokenAmount;
        claim.claimedTimestamp = now;
        return newReinsurancePoolId;
    }

    /***
     * @notice - Save reward rates per pool
     **/ 
    function saveRewardRate(uint8 reinsurancePoolId, uint8 rewardRate) public returns (bool) {
        ReinsurancePool storage reinsurancePool = reinsurancePools[reinsurancePoolId];  /// Key: reinsurancePoolId
        reinsurancePool.rewardRate = rewardRate;  /// e.g. 10%
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

    function getNextStakerId() private view returns (uint8 nextStakerId) {
        return currentStakerId + 1;
    }

    function getNextReinsurancePoolId() private view returns (uint8 nextReinsurancePoolId) {
        return currentReinsurancePoolId + 1;
    }

    function getNextClaimId() private view returns (uint8 nextClaimId) {
        return currentClaimId + 1;
    }

    function getStaker(uint8 stakerId) public view returns (Staker memory _staker) {
        Staker memory staker = stakers[stakerId];  /// Key: stakerId
        return staker;
    }     

    function getReinsurancePool(uint8 reinsurancePoolId) public view returns (ReinsurancePool memory _reinsurancePool) {
        ReinsurancePool memory reinsurancePool = reinsurancePools[reinsurancePoolId];  /// Key: reinsurancePoolId
        return reinsurancePool;
    } 

    function getRewardRate(uint8 reinsurancePoolId) public view returns (uint8 _rewardRate) {
        ReinsurancePool memory reinsurancePool = reinsurancePools[reinsurancePoolId];  /// Key: reinsurancePoolId
        uint8 rewardRate = reinsurancePool.rewardRate;  /// e.g. 10%

        return rewardRate;
    }    

}
