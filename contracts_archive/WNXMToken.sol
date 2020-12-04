pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

/// [Note]: @openzeppelin/contracts v2.5.1
import { ERC20Detailed } from "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import { ERC20Mintable } from "@openzeppelin/contracts/token/ERC20/ERC20Mintable.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";


/***
 * @notice - Wrapped NXM token contract
 **/
contract WNXMToken is ERC20Detailed, ERC20Mintable {
    using SafeMath for uint;

    constructor(address _initialTokenHolder, uint _initialSupply) 
        public 
        ERC20Detailed("Wrapped NXM Token", "WNXM", 18) 
        ERC20Mintable()
    {
        _mint(_initialTokenHolder, _initialSupply);
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
