// https://eips.ethereum.org/EIPS/eip-20
// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.8.1;

interface Token {

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
      require(b <= a); c = a - b; } 
    
    function safeMul(uint a, uint b) public pure returns (uint c) { 
      c = a * b; 
      require(a == 0 || c / a == b); } 
    
    function safeDiv(uint a, uint b) public pure returns (uint c) { 
      require(b > 0);
      c = a / b;
    }
}

contract MJWToken is Token, SafeMath {
    //three optional items
    string public name;
    string public symbol;
    uint8 public decimals;
    
    uint256 public _totalSupply;
    
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;
    
    constructor () public {
        name = "MJWToken";
        symbol = "MJW";
        decimals = 18;
        _totalSupply = 100000000000000000000000000;
        
        balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }
  
  // Six mandatory functions

  //Determines the total number of tokens created minus the balance of the contract owner
  function totalSupply() public override view returns(uint) {
    return _totalSupply - balances[address(0)];
  }

  //Returns the number of tokens that a particular address has
  function balanceOf(address tokenHolder) public override view returns(uint balance) {
    return balances[tokenHolder];
  }

  //Makes sure that the user has the minimum number of tokens required for the transaction
  function allowance(address tokenHolder, address spender) public override view returns(uint remaining) {
    return allowed[tokenHolder][spender];
  }

  //Contract owner can give their approval to the user to collect the required number of tokens from the contract's address
  function approve (address spender, uint tokens) public override returns(bool success) {
    allowed[msg.sender][spender] = tokens;
    emit Approval(msg.sender, spender, tokens);
    return true;
  }

  //Contract owner can send a given amount of tokens to another address
  function transfer(address to, uint tokens) public override returns (bool success) {
    balances[msg.sender] = safeSub(balances[msg.sender], tokens);
    balances[to] = safeAdd(balances[to], tokens);

    emit Transfer(msg.sender, to, tokens);
    return true;
  }

  //This function helps to automate transfers to and from specfic accounts
  function transferFrom (address from, address to, uint tokens) public override
	returns (bool success) {
    balances[from] = safeSub(balances[from], tokens);
    allowed[from][msg.sender] = safeSub(allowed[from][msg.sender], tokens);
    balances[to] = safeAdd(balances[to], tokens);
        
	emit Transfer(from, to, tokens);
    return true;
  }
}