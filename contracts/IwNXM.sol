// File: contracts/wNXM.sol
// Reference from: https://etherscan.io/address/0x0d438f3b5175bebc262bf23753c1e53d03432bde#code

pragma solidity ^0.5.0;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract IwNXM is IERC20 {
    function wrap(uint256 _amount) external;

    function unwrap(uint256 _amount) external;

    function unwrapTo(address _to, uint256 _amount) external;

    function canWrap(address _owner, uint256 _amount) external view;

    function canUnwrap(address _owner, address _recipient, uint256 _amount)
        external
        view
        returns (bool success, string memory reason);

    /// @dev Method to claim junk and accidentally sent tokens
    function claimTokens(IERC20 _token, address payable _to, uint256 _balance) external;
}
