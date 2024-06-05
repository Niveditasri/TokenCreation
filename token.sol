// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

/* 1. Your contract will have public variables that store the details about your coin (Token Name, Token Abbrv., Total Supply)
   2. Your contract will have a mapping of addresses to balances (address => uint)
   3. You will have a mint function that takes two parameters: an address and a value.
   The function then increases the total supply by that number and increases the balance of the address by that amount.
   4. Your contract will have a burn function, which works the opposite of the mint function, as it will destroy tokens. 
   It will take an address and value just like the mint functions. 
   It will then deduct the value from the total supply and from the balance of the address.
   5. Lastly, your burn function should have conditionals to make sure the balance of account is greater than or equal 
   to the amount that is supposed to be burned.
*/
contract MyToken {

    // Public variables to store token details
    string public name;
    string public symbol;
    uint256 public totalSupply;

    // Mapping from addresses to their balances
    mapping(address => uint256) public balances;

    // Constructor to initialize the token details
    constructor(string memory _name, string memory _symbol, uint256 _initialSupply) {
        name = _name;
        symbol = _symbol;
        totalSupply = _initialSupply;
        balances[msg.sender] = _initialSupply; // Assign the entire initial supply to the contract deployer
    }

    // Mint function to create new tokens
    function mint(address _to, uint256 _amount) public {
        require(_to != address(0), "Cannot mint to the zero address");
        totalSupply += _amount;
        balances[_to] += _amount;
        emit Transfer(address(0), _to, _amount);
    }

    // Burn function to destroy tokens
    function burn(address _from, uint256 _amount) public {
        require(balances[_from] >= _amount, "Burn amount exceeds balance");
        totalSupply -= _amount;
        balances[_from] -= _amount;
        emit Transfer(_from, address(0), _amount);
    }

    // Event to log token transfers
    event Transfer(address indexed from, address indexed to, uint256 value);
}