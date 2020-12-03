pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/math/SafeMath.sol";

import "./commons/MainStorages.sol";


/***
 * @notice - This contract is for saving methods into the main structs (which are defined in the CommonObjects.sol)
 **/
contract MainStorage is MainStorages {
    using SafeMath for uint;

    uint8 public currentReinsurancePoolId;  /// Reinsurance Pool ID

    constructor() public {}


    /***
     * @notice - Save a reinsurance pool's data
     **/ 
    function saveReinsurancePool(address reinsurancePoolAddress) public returns (bool) {
        uint8 newReinsurancePoolId = getNextReinsurancePoolId();
        currentReinsurancePoolId++;

        ReinsurancePool storage reinsurancePool = reinsurancePools[newReinsurancePoolId];  /// Key: reinsurancePoolId
        reinsurancePool.reinsurancePoolAddress = reinsurancePoolAddress;
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

    function getNextReinsurancePoolId() private view returns (uint8 nextReinsurancePoolId) {
        return currentReinsurancePoolId + 1;
    }

}
