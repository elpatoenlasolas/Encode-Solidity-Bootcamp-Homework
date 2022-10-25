// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract VolcanoCoin {
    uint256 totalSupply = 10000;
    address owner;
    mapping(address=>uint256) public balances;

    struct Payment {
        uint amount;
        address recipient;
    }

    mapping(address=>Payment[]) public payments;

    event TotalSupplyUpdated(uint);
    event TokenTransfer(uint,address);
    constructor(){
        owner = msg.sender;
        balances[owner] = totalSupply;
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    function getTotalSupply() public view returns(uint256){
        return totalSupply;
    }

    function increaseTotalSupply() public onlyOwner{
        totalSupply += 1000;
        emit TotalSupplyUpdated(totalSupply);
    }
    
    function transfer(uint256 amount,address recipient) public{
        require(balances[msg.sender] >= amount);
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        Payment[] storage personalPayments = payments[msg.sender];
        personalPayments.push(Payment(amount,recipient));
        emit TokenTransfer(amount,recipient);
    }
}
