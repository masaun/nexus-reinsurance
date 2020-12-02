pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;


/***
 * @notice - Deployed as per settings delivered by the Reinsurance Pool Manager Contract
 *         - Each ReinsurancePool has a contract address
 *         - Liquidity providers lock-up LP tokens as per the lock structure.
 *         - LP’s get wNXM rewards as per the reward structure. 
 *         - X wNXM streamed per block split proportionally between all LP’s that aren’t in the un-lock period.
 **/
contract NexusReinsurancePool {
    constructor() public {}


    /***
     * @notice - Claim triggers are defined if MCR% drops below a certain threshold (e.g. 80%) then a certain amount of LP tokens are taken and injected into Nexus Mutual as capital.
     **/
    function claimForTakingLPToken() public returns (bool) {
        uint DefaultMCRRate = 80;  /// [Note]: 80%. This is temporary rate.
        if (DefaultMCRRate < 80) {
            /// [Todo]: a certain amount of LP tokens are taken and injected into Nexus Mutual as capital
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
