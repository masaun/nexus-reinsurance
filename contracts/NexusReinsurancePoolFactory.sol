pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

import { MainStorage } from  "./mainStorage/MainStorage.sol";
import { NexusReinsurancePool } from "./NexusReinsurancePool.sol";

import { IUniswapV2Pair } from './uniswap/interfaces/IUniswapV2Pair.sol';


/***
 * @notice - Template contract that can deploy reinsurance pools. 
 *         - Important aspect for Nexus Mutual is that the template is configurable enough for the goals required.
 * @dev - TO DO: add in detailed configurations, check if they meet Nexus requirements.
 **/
contract NexusReinsurancePoolFactory {
    MainStorage public mainStorage;

    IUniswapV2Pair public uni_ETH_DAI;
    IUniswapV2Pair public uni_ETH_USDC;

    address[] nexusReinsurancePools;
    address payable NEXUS_REINSURANCE_POOL_MANAGER;  

    constructor(MainStorage _mainStorage, address payable _nexusReinsurancePoolManager, IUniswapV2Pair _uni_ETH_DAI, IUniswapV2Pair _uni_ETH_USDC) public {
        mainStorage = _mainStorage;

        NEXUS_REINSURANCE_POOL_MANAGER = address(uint160(_nexusReinsurancePoolManager));  /// [Note]: address(uint160()) is a method for converting address to payable    
        uni_ETH_DAI = _uni_ETH_DAI;
        uni_ETH_USDC = _uni_ETH_USDC;
    }


    ///------------------------------------------------------------
    /// Functions that new Nexus Reinsurance Pool creation
    ///------------------------------------------------------------

    /***
     * @notice - Create a new Nexus Reinsurance Pool
     **/
    function createNexusReinsurancePool() public returns (address _nexusReinsurancePool) {
        NexusReinsurancePool nexusReinsurancePool = new NexusReinsurancePool(NEXUS_REINSURANCE_POOL_MANAGER, uni_ETH_DAI, uni_ETH_USDC);
        nexusReinsurancePools.push(address(nexusReinsurancePool));

        mainStorage.saveReinsurancePool(address(nexusReinsurancePool));

        return address(nexusReinsurancePool);
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
