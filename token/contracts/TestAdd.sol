pragma solidity ^0.6.0;

import "./SafeMath.sol";

contract TestAdd {

    function testAdd(uint256 a, uint256 b) public view returns (uint256 c) {
        c = SafeMath.add(a,b);
        return c;
    }
}
