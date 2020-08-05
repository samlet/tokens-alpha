// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract MappingExample {
    mapping(address => uint) public balances;

    function update(uint newBalance) public {
        balances[msg.sender] = newBalance;
    }
}

contract MappingTest {
    function f() public returns (address, uint) {
        MappingExample m = new MappingExample();
        m.update(100);
        return (address(this), m.balances(address(this)));
    }
}
