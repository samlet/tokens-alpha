from brownie import Token, accounts

def main():
    """
    $ brownie run deploy.py --network ropsten
    :return:
    """
    acct = accounts.load('samlet')
    Token.deploy("My Real Token", "RLT", 18, 1e28, {'from': acct})


