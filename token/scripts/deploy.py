from brownie import Token, accounts

def main():
    """
    $ brownie run deploy.py --network rinkeby
    :return:
    """
    acct = accounts.load('flyer')
    Token.deploy("My Real Token", "RLT", 18, 1e28, {'from': acct})


