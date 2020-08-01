pragma solidity >=0.4.22 <0.5.0;

contract Simple{

    uint private _num;
    function store(uint256 num) public {
        _num = num;
    }

    function get() public view returns (uint256){
        return _num;
    }
}

