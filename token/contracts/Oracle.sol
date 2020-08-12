pragma solidity ^0.4.11;

contract Oracle {
    struct Request {
        bytes data;
        function(bytes memory) external callback;
    }

    Request[] requests;

    event NewRequest(uint);

    function query(bytes data, function(bytes memory) external callback) public {
        requests.push(Request(data, callback));
        NewRequest(requests.length - 1);
    }

    function reply(uint requestID, bytes response) public {
        // 这里要验证 reply 来自可信的源
        requests[requestID].callback(response);
    }
}

contract OracleUser1 {
    Oracle constant oracle = Oracle(0x1234567); // 已知的合约
    function buySomething() {
        oracle.query("USD", this.oracleResponse);
    }

    function oracleResponse(bytes response) public {
        require(msg.sender == address(oracle));
        // 使用数据
    }
}

contract OracleUser2 {
    Oracle oracle;
    constructor (address _oracleAddr) public{
        oracle=Oracle(_oracleAddr);
    }

    function buySomething() {
        oracle.query("USD", this.oracleResponse);
    }

    function oracleResponse(bytes response) public {
        require(msg.sender == address(oracle));
        // 使用数据
    }
}

