from brownie import Fn, accounts

def sha():
    """
    >>> run('fn','sha')
    :return:
    """
    f = Fn.deploy({'from': accounts[0]})
    return f.foo_sha(b"potato")

def main():
    """
    $ brownie run fn
    :return:
    """
    f= Fn.deploy({'from': accounts[0]})
    print('...')
    print('invoke keccak256 and sha256:',
          f.foo(b"potato"),
          f.foo_sha(b"potato"))
    return f

