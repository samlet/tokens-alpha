from brownie import InfoFeed, InfoConsumer, accounts

def main():
    """
    $ t storage
    :return:
    """
    feed=InfoFeed.deploy({'from': accounts[0]})
    f= InfoConsumer.deploy({'from': accounts[0]})
    f.setFeed(feed.address)
    tx=f.callFeed()
    print(tx.return_value)


