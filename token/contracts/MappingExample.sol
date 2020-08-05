// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract MappingExample {
    mapping(address => uint) public balances;
    mapping(uint => uint) public amounts;

    function update(uint newBalance) public {
        balances[msg.sender] = newBalance;
    }
    function update(address item, uint newBalance) public {
        balances[item] = newBalance;
    }
    function setAmount(uint item, uint value) public{
        amounts[item]=value;
    }
}

contract MappingTest {
    function f() public returns (address, uint) {
        MappingExample m = new MappingExample();
        m.update(100);
        return (address(this), m.balances(address(this)));
    }
}
