pragma solidity ^0.4.16;

contract Simple {
    // 输出参数名可以被省略。输出值也可以使用 return 语句指定。
    // return 语句也可以返回多值，参阅：ref:multi-return。
    // 返回的输出参数被初始化为 0；如果它们没有被显式赋值，它们就会一直为 0。
    function arithmetics(uint _a, uint _b)
        public
        pure
        returns (uint o_sum, uint o_product)
    {
        o_sum = _a + _b;
        o_product = _a * _b;
    }
}

