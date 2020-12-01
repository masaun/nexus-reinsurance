pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

import { MCR } from "./nexus-mutual/modules/capital//MCR.sol";
import { NXMToken } from "./nexus-mutual/modules/token/NXMToken.sol";
import { PooledStaking } from "./nexus-mutual/modules/staking/PooledStaking.sol";
import { Claims } from "./nexus-mutual/modules/claims/Claims.sol";


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

    constructor() public {}

    /***
     * @notice - Receives NXM from Nexus Mutual and converts to wNXM
     **/


    /***
     * @notice - Sends wNXM rewards to the Reinsurance pools.
     **/


    /***
     * @notice - Receives LP tokens in the event of a claim
     **/


    /***
     * @notice - Converts LP tokens into underlying assets
     **/     


    /***
     * @notice - Sends underlying assets into Nexus Mutual capital pool
     **/ 



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
