pragma solidity ^0.6.0;

import "@hq20/contracts/contracts/state/StateMachine.sol";


contract TestStateMachine is StateMachine {

    function createTransition(
        bytes32 _originState,
        bytes32 _targetState
    ) external virtual {
        _createTransition(_originState, _targetState);
    }

    function transition(bytes32 _targetState) external virtual {
        _transition(_targetState);
    }

}