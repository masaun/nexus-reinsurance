pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import { IUniswapV2Pair } from '../../uniswap/interfaces/IUniswapV2Pair.sol';

contract MainObjects {

    struct Staker {  /// [Key]: staker ID
        address stakerAddress;
        IUniswapV2Pair stakedLPToken;
        uint stakedAmount;
        uint stakedTimestamp;   /// Staked date
    }

    struct ReinsurancePool {  /// [Key]: reinsurancePoolId
        address reinsurancePoolAddress;
        uint8 rewardRate;
    }

}
