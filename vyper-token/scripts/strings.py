from brownie import Strings, accounts

def main():
    """
    $ brownie run strings
    :return:
    """
    f= Strings.deploy({'from': accounts[0]})
    print('invoke strings:',
          f.foo("why","hello","there"),
          )
    return f

