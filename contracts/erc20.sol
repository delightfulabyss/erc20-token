// https://eips.ethereum.org/EIPS/eip-20
// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <=0.8.1;

interface Token {
    /// @notice Determines the total number of tokens created minus the balance of the contract owner
    /// @return total total number of tokens in circulation
    function totalSupply() external view returns(uint256 total);

    /// @param _owner The address from which the balance will be retrieved
    /// @return balance the balance
    function balanceOf(address _owner) external view returns (uint256 balance);

    /// @notice send `_value` token to `_to` from `msg.sender`
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return success Whether the transfer was successful or not
    function transfer(address _to, uint256 _value) external returns (bool success);

    /// @notice send `_value` token to `_to` from `_from` on the condition it is approved by `_from`
    /// @param _from The address of the sender
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return success Whether the transfer was successful or not
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);

    /// @notice `msg.sender` approves `_addr` to spend `_value` tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @param _value The amount of wei to be approved for transfer
    /// @return success Whether the approval was successful or not
    function approve(address _spender, uint256 _value) external returns (bool success);

    /// @param _owner The address of the account owning tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @return remaining Amount of remaining tokens allowed to spent
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract SafeMath {
    function safeAdd(uint a, uint b) public pure returns (uint c) {
      c = a + b;
      require(c >= a);
    }
    
    function safeSub(uint a, uint b) public pure returns (uint c) {
      require(b <= a); 
      c = a - b; } 
    
    function safeMul(uint a, uint b) public pure returns (uint c) { 
      c = a * b; 
      require(a == 0 || c / a == b);
    } 
    
    function safeDiv(uint a, uint b) public pure returns (uint c) { 
      require(b > 0);
      c = a / b;
    }
}

contract MatthewToken is Token, SafeMath {
    //Three optional variables
    string public name;
    string public symbol;
    uint8 public decimals;
    
    //Total number of tokens
    uint256 public _totalSupply;
    
    //Mapping of addresses to balances
    mapping(address => uint256) balances;

    //Mapping of owner addresses to a mapping of spenders and allowed amounts
    mapping(address => mapping(address => uint256)) allowed;
    
    constructor () {
        name = "MatthewToken";
        symbol = "MJW";
        decimals = 18;
        _totalSupply = 100000000000000000000000000;
        
        balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }
  
  // Six mandatory functions

  //Determines the total number of tokens created minus the balance of the contract owner
  function totalSupply() public override view returns(uint256 total) {
    return _totalSupply - balances[address(0)];
  }

  //Returns the number of tokens that a particular address has
  function balanceOf(address _owner) public override view returns(uint256 balance) {
    return balances[_owner];
  }

  //Returns the number of tokens allowed by the owner to be spent by the spender
  function allowance(address _owner, address _spender) public override view returns(uint256 remaining) {
    return allowed[_owner][_spender];
  }

  //Contract owner can give their approval to an address to spend a given amount of their tokens on their behalf
  function approve (address _spender, uint256 _value) public override returns(bool success) {
    allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  //Contract owner can send a given amount of tokens to another address
  //If the requested amount is greater than the owner's balance, an error will be thrown
  function transfer(address _to, uint256 _value) public override returns (bool success) {
    balances[msg.sender] = safeSub(balances[msg.sender], _value);
    balances[_to] = safeAdd(balances[_to], _value);

    emit Transfer(msg.sender, _to, _value);
    return true;
  }

  //This function helps to automate transfers to and from specfic accounts
  //If the requested value is greater than what is allowed by the owner, an error will be thrown
  function transferFrom (address _from, address _to, uint256 _value) public override
	returns (bool success) {
    balances[_from] = safeSub(balances[_from], _value);
    allowed[_from][msg.sender] = safeSub(allowed[_from][msg.sender], _value);
    balances[_to] = safeAdd(balances[_to], _value);
        
	emit Transfer(_from, _to, _value);
    return true;
  }
}