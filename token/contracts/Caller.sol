pragma solidity ^0.4.6;

/*
 合约接口仅提供3个功能，所有功能都用调用address。这是已部署Callee合同的地址。
 也可以使用某个地址初始化合同，并在一段时间后更改此地址，例如使用目标合同的新版本。
*/
contract Caller {
    function someAction(address addr) returns(uint) {
        CalleeIntf c = CalleeIntf(addr);
        return c.getValue(100);
    }

    function storeAction(address addr) returns(uint) {
        CalleeIntf c = CalleeIntf(addr);
        c.storeValue(100);
        return c.getValues();
    }

    function someUnsafeAction(address addr) {
        addr.call(bytes4(keccak256("storeValue(uint256)")), 100);
    }
}

// 该简单协定包含一个整数数组，提供了一种添加值和检索存储的值量的方法。
// 它还具有getValue接收输入并返回更改后的输出的方法，以展示返回值和参数的工作方式。
contract CalleeIntf {
    function getValue(uint initialValue) returns(uint);
    function storeValue(uint value);
    function getValues() returns(uint);
}

