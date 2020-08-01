// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract WithdrawalContract {
    address public richest;
    uint public mostSent;

    mapping (address => uint) pendingWithdrawals;

    constructor() public payable {
        richest = msg.sender;
        mostSent = msg.value;
    }

    function becomeRichest() public payable returns (bool) {
        if (msg.value > mostSent) {
            pendingWithdrawals[richest] += msg.value;
            richest = msg.sender;
            mostSent = msg.value;
            return true;
        } else {
            return false;
        }
    }

    function withdraw() public {
        uint amount = pendingWithdrawals[msg.sender];
        // 记住，在发送资金之前将待发金额清零
        // 来防止重入（re-entrancy）攻击
        pendingWithdrawals[msg.sender] = 0;
        msg.sender.transfer(amount);
    }
}
