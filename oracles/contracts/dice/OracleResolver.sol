pragma solidity >=0.4.22 <0.5.0;

contract OracleResolver {
    address owner;

    address public oracleAddress;

    function OracleResolver() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        if (msg.sender != owner) throw;
        _;
    }

    function setOracleAddress(address _addr) onlyOwner {
        oracleAddress = _addr;
    }
    
    function getOracleAddress() constant returns(address) {
        return oracleAddress;
    }
}

