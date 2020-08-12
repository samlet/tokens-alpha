pragma solidity ^0.4.24;

contract InfoFeed {
    function _info() public payable returns (uint ret) { return 42; }
}

contract InfoConsumer {
    InfoFeed feed;
    function setFeed(address addr) public { feed = InfoFeed(addr); }
    // function callFeed() public { feed._info.value(10).gas(800)(); }
    function callFeed() public returns (uint val){ val=feed._info(); }
}

