from brownie import DappToken, accounts

def main():
    _name = 'Dapp Token'
    _symbol = 'DAPP'
    _decimals = 18
    f= DappToken.deploy(_name, _symbol, _decimals, {'from': accounts[0]})
    print('invoke:', f.name(), f.symbol(), f.decimals())





