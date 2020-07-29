stored_data: uint256

@external
def set(new_value: uint256):
    self.stored_data = new_value

@view
@external
def get() -> uint256:
    return self.stored_data
