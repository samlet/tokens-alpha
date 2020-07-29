@external
@view
def foo(_value: Bytes[100]) -> bytes32:
    return keccak256(_value)

@external
@view
def foo_sha(_value: Bytes[100]) -> bytes32:
    return sha256(_value)

