pragma solidity 0.5.8;

import "./ERC20.sol";

/**
 * @dev COS token
 */
contract COS is ERC20 {
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    /**
     * @dev Sets the values for `name`, `symbol`, and `decimals`. All three of
     * these values are immutable: they can only be set once during
     * construction.
     */
    constructor () public {
        _name = "COS";
        _symbol = "COS";
        _decimals = 18;
        _totalSupply = 200e6 * 10**18; //200 millions
        // transfer(msg.sender, _totalSupply);
        _balances[msg.sender] = _totalSupply;
        emit Transfer(address(this), msg.sender, _totalSupply);
    }

    /**
     * @dev ardrop tokens to multiple addresses
     */
    function airdrop(address[] calldata _recipients, uint256[] calldata _values) external returns (bool) {
        require(_recipients.length == _values.length, "Inconsistent data lengths");
        uint256 senderBalance = _balances[msg.sender];
        uint256 length = _values.length;
        for (uint256 i = 0; i < length; i++) {
            uint256 value = _values[i];
            address to = _recipients[i];
            require(senderBalance >= value, "Insufficient Balance");
            require(to != address(0), "Address is Null");
            if (msg.sender != _recipients[i])  {      
                transfer(to, value);
            }
        }
        return true;            
    }

    /**
     * Getter Functions
     */

    /**
     * @dev Returns the name of the token.
     */
    function name() public view returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation
     */
    function decimals() public view returns (uint8) {
        return _decimals;
    }
}