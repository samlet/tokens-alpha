#!/usr/bin/python3

from brownie import Token, accounts, run


def main():
    return Token.deploy("Test Token", "TST", 18, 1e21, {'from': accounts[0]})

def distribute_tokens(sender=accounts[0], receiver_list=accounts[1:]):
    """
    >>> run('token', 'distribute_tokens')
    :param sender:
    :param receiver_list:
    :return:
    """
    token = main()
    for receiver in receiver_list:
        token.transfer(receiver, 1e18, {'from': sender})

