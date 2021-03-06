pragma solidity ^0.6.0;
import "@hq20/contracts/contracts/access/AuthorizedAccess.sol";


contract TestAuthorizedAccess is AuthorizedAccess {
    constructor () public AuthorizedAccess() {}
    function testOnlyAuthorized(string memory msg)
        public view onlyAuthorized(msg) returns(bool)
    {
        return true;
    }
}
