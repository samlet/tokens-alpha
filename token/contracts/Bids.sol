pragma solidity ^0.6.0;

/**
 检索元素的数量，然后将已分解的结构检索为元组。
 */
contract Bids {
    struct Bid {
        address bidOwner;
        uint bidAmount;
        bytes32 nameEntity;
    }

    mapping(bytes32 => Bid[]) highestBidder;

    function getBidCount(bytes32 name) public view returns (uint) {
        return highestBidder[name].length;
    }

    function getBid(bytes32 name, uint index) public view returns (address, uint, bytes32) {
        // 本地存储变量是指向状态变量的指针（状态变量始终在storage中）
        Bid storage bid = highestBidder[name][index];
        return (bid.bidOwner, bid.bidAmount, bid.nameEntity);
    }
}
