pragma solidity >=0.4.22 <0.5.0;

import "./base/Ownable.sol";

contract OracleIntf is Ownable {
    //boxing results oracle
    address internal oracleAddr = 0;
    /// @notice gets the address of the boxing oracle being used
    /// @return the address of the currently set oracle
    function getOracleAddress() external view returns (address) {
        return oracleAddr;
    }

    function _setOracle(address _oracleAddress) internal returns (bool){
        return true;
    }

    /// @notice sets the address of the boxing oracle contract to use
    /// @dev setting a wrong address may result in false return value, or error
    /// @param _oracleAddress the address of the boxing oracle
    /// @return true if connection to the new oracle address was successful
    function setOracleAddress(address _oracleAddress) external onlyOwner returns (bool) {
        oracleAddr = _oracleAddress;
        return _setOracle(oracleAddr);
    }
}


