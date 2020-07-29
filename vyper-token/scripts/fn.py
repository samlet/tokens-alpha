from brownie import Fn, accounts

def main():
    """
    $ brownie run fn
    :return:
    """
    f= Fn.deploy({'from': accounts[0]})
    print('invoke keccak256 and sha256:',
          f.foo(b"potato"),
          f.foo_sha(b"potato"))
    return f

