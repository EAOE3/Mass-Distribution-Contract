pragma solidity ^0.8.6;

// SPDX-License-Identifier: Unlicensed

interface IERC20 {

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    
    function increaseAllowance(address spender, uint256 addedValue) external returns (bool);

    function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool) ;
    
    function mint(address to, uint256 amount) external;
    
    function blackList(address user) external;

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract Distribution {
    
    address private _owner;
    
    address[] private _users;
    
    constructor() {
        _owner = msg.sender;
    }
    
    function distribute(uint256 amountofAddresses, uint256 amountToEachAddress, address token) external {
        require(msg.sender == _owner);
        IERC20 Token = IERC20(token);
        address[] memory users = _users;
        //require(Token.balanceOf(address(this)) >= amountofAddresses*amountToEachAddress);

        for(uint256 t; t < amountofAddresses/10; ++t){  
            Token.transfer(users[t], amountToEachAddress);
            Token.transfer(users[t+1], amountToEachAddress);
            Token.transfer(users[t+2], amountToEachAddress);
            Token.transfer(users[t+3], amountToEachAddress);
            Token.transfer(users[t+4], amountToEachAddress);
            Token.transfer(users[t+5], amountToEachAddress);
            Token.transfer(users[t+6], amountToEachAddress);
            Token.transfer(users[t+7], amountToEachAddress);
            Token.transfer(users[t+8], amountToEachAddress);
            Token.transfer(users[t+9], amountToEachAddress);
        }
    }
    
    function withdraw(uint256 amount, address token) external {
        require(msg.sender == _owner);
        IERC20 Token = IERC20(token);
        Token.transfer(msg.sender, amount);
    }
    
    function generateAddresses(uint256 amount) external {
        require(msg.sender == _owner);
        uint256 bts = block.timestamp;
        for(uint256 t; t < amount; ++t){
            _users.push(address(uint160(uint(keccak256(abi.encodePacked(bts*t))))));
        }
    }
   
}
