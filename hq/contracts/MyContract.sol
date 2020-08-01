pragma solidity ^0.6.0;

import "@hq20/contracts/contracts/access/Hierarchy.sol";


contract MyContract is Hierarchy {
	constructor() public Hierarchy(msg.sender) {
		// do something
	}
}

