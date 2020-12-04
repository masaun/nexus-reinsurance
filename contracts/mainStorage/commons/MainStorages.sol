pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import "./MainObjects.sol";


/// main storage
contract MainStorages is MainObjects {

    mapping (uint8 => ReinsurancePool) reinsurancePools;

}
