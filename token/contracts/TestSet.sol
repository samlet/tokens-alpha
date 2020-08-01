pragma solidity ^0.6.0;

import "./SetLib.sol";

contract TestSet {
    using Set for Set.Data; // 这里是关键的修改
    Set.Data knownValues;

    function register(uint value) public {
        // Here, all variables of type Set.Data have
        // corresponding member functions.
        // The following function call is identical to
        // `Set.insert(knownValues, value)`
        // 这里， Set.Data 类型的所有变量都有与之相对应的成员函数。
        // 下面的函数调用和 `Set.insert(knownValues, value)` 的效果完全相同。
        require(knownValues.insert(value));
    }
}

