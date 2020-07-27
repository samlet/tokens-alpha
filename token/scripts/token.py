#!/usr/bin/python3

from brownie import Token, accounts


def main():
    t= Token.deploy("Test Token", "TST", 18, 1e21, {'from': accounts[0]})
    print('owner balance: ', t.balanceOf(accounts[0]))
    return t
