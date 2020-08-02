from brownie import BoxingOracle, accounts


def main():
    """
    $ t oracle
    :return:
    """
    f = BoxingOracle.deploy({'from': accounts[0]})
    print(f.testConnection())
    print(f.getAllMatches())
    print(f.addTestData())
    print('..', f.getAllMatches())
    return f
