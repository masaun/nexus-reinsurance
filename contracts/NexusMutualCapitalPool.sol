pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

/// [Note]: @openzeppelin/contracts v2.5.1
import { IERC20 } from '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";

import { NXMToken } from "./nexus-mutual/modules/token/NXMToken.sol";


/***
 * @notice - This is NexusMutualCapitalPool contract
 *         - Provides NXM rewards.
 *         - Receives capital in the event of a claim.
 *         - Formal governance to instruct the multi-sig operators of the reinsurance pool manager.
 **/
contract NexusMutualCapitalPool {
    using SafeMath for uint;

    NXMToken public nxmToken;
    IERC20 public dai;

    address NXM_TOKEN;

    constructor(NXMToken _nxmToken, IERC20 _dai) public {
        nxmToken = _nxmToken;
        dai = IERC20(address(_dai));

        NXM_TOKEN = address(_nxmToken);
    }


    /***
     * @notice - Where NXM come from is TBD.
     *           (Additional implementation for existing contracts of Nexus Mutual may be needed) 
     * @dev - Assuming that TBD above is solved, methods below has been implemented.
     **/ 


    /***
     * @notice - Provides NXM rewards (into the NexusReinsurancePoolManager contract)
     **/
    function provideNXMReward(address to, uint nxmAmount) public returns (bool) {
        /// [Notes]: "to" is NexusReinsurancePoolManager contract address. That parameter is assigned in the NexusReinsurancePoolManager contract
        nxmToken.transfer(to, nxmAmount);
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
