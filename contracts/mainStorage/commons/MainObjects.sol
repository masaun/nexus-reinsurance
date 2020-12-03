pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;


contract MainObjects {

    struct ReinsurancePool {  /// [Key]: reinsurancePoolId
        address reinsurancePoolAddress;
        uint8 rewardRate;
    }

}
