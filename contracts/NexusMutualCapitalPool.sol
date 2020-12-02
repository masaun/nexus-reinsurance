pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

/// [Note]: @openzeppelin/contracts v2.5.1

import { IERC20 } from '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";

import { NXMToken } from "./nexus-mutual/modules/token/NXMToken.sol";
import { NexusReinsurancePoolManager } from "./NexusReinsurancePoolManager.sol";


/***
 * @notice - This is NexusMutualCapitalPool contract
 *         - Provides NXM rewards.
 *         - Receives capital in the event of a claim.
 *         - Formal governance to instruct the multi-sig operators of the reinsurance pool manager.
 **/
contract NexusMutualCapitalPool {
    using SafeMath for uint;

    NXMToken public nxmToken;
    NexusReinsurancePoolManager public nexusReinsurancePoolManager;
    IERC20 public dai;

    address NXM_TOKEN;
    address NEXUS_REINSURANCE_POOL_MANAGER;

    constructor(NXMToken _nxmToken, NexusReinsurancePoolManager _nexusReinsurancePoolManager, IERC20 _dai) public {
        nxmToken = _nxmToken;
        nexusReinsurancePoolManager = _nexusReinsurancePoolManager;
        dai = IERC20(address(_dai));

        NXM_TOKEN = address(_nxmToken);
        NEXUS_REINSURANCE_POOL_MANAGER = address(_nexusReinsurancePoolManager);
    }


    /***
     * @notice - Provides NXM rewards (into the NexusReinsurancePoolManager contract)
     **/
    function provideNXMReward(uint nxmAmount) public returns (bool) {
        nxmToken.transfer(NEXUS_REINSURANCE_POOL_MANAGER, nxmAmount);
    }
    

    /***
     * @notice - Receives capital (underlying asset) in the event of a claim. 
     **/
    function receiveCapital(uint underlyingAssetAmount) public returns (bool) {
        dai.transferFrom(msg.sender, address(this), underlyingAssetAmount);
    }
    

    /***
     * @notice - Formal governance to instruct the multi-sig operators of the reinsurance pool manager.
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
