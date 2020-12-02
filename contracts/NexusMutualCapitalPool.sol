pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

/// [Note]: @openzeppelin/contracts v2.5.1
import { IERC20 } from '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";


/***
 * @notice - This is NexusMutualCapitalPool contract
 *         - Provides NXM rewards.
 *         - Receives capital in the event of a claim.
 *         - Formal governance to instruct the multi-sig operators of the reinsurance pool manager.
 **/
contract NexusMutualCapitalPool {
    using SafeMath for uint;

    IERC20 public dai;

    constructor(address _dai) public {
        dai = IERC20(_dai);
    }

    /***
     * @notice - Provides NXM rewards.
     **/
    function provideNXMReward() public returns (bool) {}
    

    /***
     * @notice - Receives capital (underlying asset) in the event of a claim. 
     **/
    function receivesCapital(uint underlyingAssetAmount) public returns (bool) {
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
