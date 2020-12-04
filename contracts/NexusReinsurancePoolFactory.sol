pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

import { MainStorage } from  "./mainStorage/MainStorage.sol";
import { NexusReinsurancePool } from "./NexusReinsurancePool.sol";


/***
 * @notice - Template contract that can deploy reinsurance pools. 
 *         - Important aspect for Nexus Mutual is that the template is configurable enough for the goals required.
 * @dev - TO DO: add in detailed configurations, check if they meet Nexus requirements.
 **/
contract NexusReinsurancePoolFactory {
    MainStorage public mainStorage;

    address[] nexusReinsurancePools;
    address payable NEXUS_REINSURANCE_POOL_MANAGER;

    constructor(MainStorage _mainStorage, address payable _nexusReinsurancePoolManager) public {
        mainStorage = _mainStorage;

        NEXUS_REINSURANCE_POOL_MANAGER = address(uint160(_nexusReinsurancePoolManager));  /// [Note]: address(uint160()) is a method for converting address to payable    
    }


    ///------------------------------------------------------------
    /// Functions that new Nexus Reinsurance Pool creation
    ///------------------------------------------------------------

    /***
     * @notice - Create a new Nexus Reinsurance Pool
     **/
    function createNexusReinsurancePool() public returns (bool) {
        NexusReinsurancePool nexusReinsurancePool = new NexusReinsurancePool(NEXUS_REINSURANCE_POOL_MANAGER);
        nexusReinsurancePools.push(address(nexusReinsurancePool));

        mainStorage.saveReinsurancePool(address(nexusReinsurancePool));
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
