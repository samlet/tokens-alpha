pragma solidity ^0.6.0;

contract AccessRestriction {
    // 这些将在构造阶段被赋值
    // 其中，`msg.sender` 是
    // 创建这个合约的账户。
    address public owner = msg.sender;
    uint public creationTime = now;

    // 修饰器可以用来更改
    // 一个函数的函数体。
    // 如果使用这个修饰器，
    // 它会预置一个检查，仅允许
    // 来自特定地址的
    // 函数调用。
    modifier onlyBy(address _account)
    {
        require(
            msg.sender == _account,
            "Sender not authorized."
        );
        // 不要忘记写 `_;`！
        // 它会被实际使用这个修饰器的
        // 函数体所替代。
        _;
    }

    // 使 `_newOwner` 成为这个合约的
    // 新所有者。
    function changeOwner(address _newOwner)
        public
        onlyBy(owner)
    {
        owner = _newOwner;
    }

    modifier onlyAfter(uint _time) {
        require(
            now >= _time,
            "Function called too early."
        );
        _;
    }

    // 抹掉所有者信息。
    // 仅允许在合约创建成功 6 周以后
    // 的时间被调用。
    function disown()
        public
        onlyBy(owner)
        onlyAfter(creationTime + 6 weeks)
    {
        delete owner;
    }

    // 这个修饰器要求对函数调用
    // 绑定一定的费用。
    // 如果调用方发送了过多的费用，
    // 他/她会得到退款，但需要先执行函数体。
    // 这在 0.4.0 版本以前的 Solidity 中很危险，
    // 因为很可能会跳过 `_;` 之后的代码。
    modifier costs(uint _amount) {
        require(
            msg.value >= _amount,
            "Not enough Ether provided."
        );
        _;
        if (msg.value > _amount)
            msg.sender.send(msg.value - _amount);
    }

    function forceOwnerChange(address _newOwner)
        public
        payable
        costs(200 ether)
    {
        owner = _newOwner;
        // 这只是示例条件
        if (uint(owner) & 0 == 1)
            // 这无法在 0.4.0 版本之前的
            // Solidity 上进行退还。
            return;
        // 退还多付的费用
    }
}

