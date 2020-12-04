pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";


/***
 * @notice - Deployed as per settings delivered by the Reinsurance Pool Manager Contract
 *         - Each ReinsurancePool has a contract address
 *         - Liquidity providers lock-up LP tokens as per the lock structure.
 *         - LP’s get wNXM rewards as per the reward structure. 
 *         - X wNXM streamed per block split proportionally between all LP’s that aren’t in the un-lock period.
 **/
contract NexusReinsurancePool {
    using SafeMath for uint;

    uint8 defaultMCRRate = 90;  /// [Note]: 90%
    uint8 currentMCRRate;       /// [Todo]: Retrieve current MCR rate

    address payable NEXUS_REINSURANCE_POOL_MANAGER;

    constructor(address payable _nexusReinsurancePoolManager) public {
        NEXUS_REINSURANCE_POOL_MANAGER = _nexusReinsurancePoolManager;
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
