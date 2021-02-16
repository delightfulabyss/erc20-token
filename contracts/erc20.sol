pragma solidity ^0.7.0 ;

abstract contract ERC20Interface {
    function totalSupply() 
		virtual
        public 
		view 
		returns (uint);

    function balanceOf(address tokenOwner) 
		virtual
        public 
		view 
		returns (uint balance);
    
	function allowance
		(address tokenOwner, address spender) 
		virtual
        public 
		view 
		returns (uint remaining);

    function transfer(address to, uint tokens) virtual public 
		returns (bool success);
    
	function approve(address spender, uint tokens) virtual public 
		returns (bool success);

    function transferFrom 
		(address from, address to, uint tokens) virtual public 
		returns (bool success);


    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

contract MJWToken {
    //three optional rules
    string public name;
    string public symbol;
    uint8 public decimals;

    constructor () public {
        name = "MJWToken";
        symbol = "MJW";
        decimals = 18;
    }
}