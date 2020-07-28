from brownie import accounts
from brownie.test import given, strategy

@given(value=strategy('uint256', max_value=10000))
def test_transfer_amount(token, value):
    balance = token.balanceOf(accounts[0])
    token.transfer(accounts[1], value, {'from': accounts[0]})

    assert token.balanceOf(accounts[0]) == balance - value
