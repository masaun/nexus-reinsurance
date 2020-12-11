pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import { MainObjects } from "./MainObjects.sol";


/// main storage
contract MainStorages is MainObjects {

    mapping (uint8 => Staker) stakers;                    /// [Key]: staker ID
    mapping (uint8 => ReinsurancePool) reinsurancePools;  /// [Key]: reinsurancePoolId
    mapping (uint8 => Claim) claims;                      /// [Key]: claim ID

}
