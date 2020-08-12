pragma solidity ^0.4.16;

contract ArrayContract {
    uint[2**20] m_aLotOfIntegers;
    // 注意下面的代码并不是一对动态数组，
    // 而是一个数组元素为一对变量的动态数组（也就是数组元素为长度为 2 的定长数组的动态数组）。
    bool[2][] m_pairsOfFlags;
    // newPairs 存储在 memory 中 —— 函数参数默认的存储位置

    function setAllFlagPairs(bool[2][] newPairs) public {
        // 向一个 storage 的数组赋值会替代整个数组
        m_pairsOfFlags = newPairs;
    }

    function setFlagPair(uint index, bool flagA, bool flagB) public {
        // 访问一个不存在的数组下标会引发一个异常
        m_pairsOfFlags[index][0] = flagA;
        m_pairsOfFlags[index][1] = flagB;
    }

    function changeFlagArraySize(uint newSize) public {
        // 如果 newSize 更小，那么超出的元素会被清除
        m_pairsOfFlags.length = newSize;
    }

    function clear() public {
        // 这些代码会将数组全部清空
        delete m_pairsOfFlags;
        delete m_aLotOfIntegers;
        // 这里也是实现同样的功能
        m_pairsOfFlags.length = 0;
    }

    bytes m_byteData;

    function byteArrays(bytes data) public {
        // 字节的数组（语言意义中的 byte 的复数 ``bytes``）不一样，因为它们不是填充式存储的，
        // 但可以当作和 "uint8[]" 一样对待
        m_byteData = data;
        m_byteData.length += 7;
        m_byteData[3] = byte(8);
        delete m_byteData[2];
    }

    function addFlag(bool[2] flag) public returns (uint) {
        return m_pairsOfFlags.push(flag);
    }

    function createMemoryArray(uint size) public pure returns (bytes) {
        // 使用 `new` 创建动态 memory 数组：
        uint[2][] memory arrayOfPairs = new uint[2][](size);
        // 创建一个动态字节数组：
        bytes memory b = new bytes(200);
        for (uint i = 0; i < b.length; i++)
            b[i] = byte(i);
        return b;
    }
}
