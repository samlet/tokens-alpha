pragma solidity ^0.4.24;

contract foo {
    function bar1(uint32 x, bool y) public pure returns (address, bytes) {
        return (address(3), hex"01020304");
    }

    function bar2(uint32 x, bool y) public pure returns (bool) {
        return !y;
    }

//    function test() public {
//        (address f1, bytes32 f2) = bar1(102, false);
//        bool f3 = bar2({x: 255, y: true});
//    }
}