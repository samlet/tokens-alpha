from brownie import Storage, accounts

def main():
    """
    $ t storage
    :return:
    """
    f= Storage.deploy({'from': accounts[0]})
    f.set(100)
    print('invoke:',
          f.get(),
          )
    return f


