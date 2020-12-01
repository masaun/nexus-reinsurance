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
    MCR public mcr;
    NXMToken public nxmToken;
    PooledStaking public pooledStaking;
    Claims public claims;

    address MCR_ADDRESS;
    address NXM_TOKEN; 
    address POOLED_STAKING;
    address CLAIMS; 

    constructor(MCR _mcr,  NXMToken _nxmToken, PooledStaking _pooledStaking, Claims _claims) public {
        mcr = _mcr;
        nxmToken = _nxmToken;
        pooledStaking = _pooledStaking;
        claims = _claims;

        MCR_ADDRESS = address(_mcr);
        NXM_TOKEN = address(_nxmToken);
        POOLED_STAKING = address(_pooledStaking);
        CLAIMS = address(_claims); 
    }

    /***
     * @notice - Receives NXM from Nexus Mutual and converts to wNXM
     **/
    function convertFromNXMToWNXM(address _nexusMutual, uint receivedNXMAmount) public returns (bool) {
        /// Receives NXM from Nexus Mutual
        nxmToken.transferFrom(_nexusMutual, address(this), receivedNXMAmount);
    
        /// Converts from NXM to wNXM
        _convertFromNXMToWNXM(receivedNXMAmount);
    }


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
    function _convertFromNXMToWNXM(uint receivedNXMAmount) internal returns (bool) {
        /// [Todo]: Write converts code into here
    }





    ///------------------------------------------------------------
    /// Getter functions
    ///------------------------------------------------------------
 


    ///------------------------------------------------------------
    /// Private functions
    ///------------------------------------------------------------

}
