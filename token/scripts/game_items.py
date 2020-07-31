from brownie import GameItems, accounts

def main():
    """
    $ brownie run game_items
    :return:
    """
    f= GameItems.deploy({'from': accounts[0]})
    print('invoke:',
          f.balanceOf(accounts[0], 3),
          )
    deployerAddress=accounts[0]
    playerAddress=accounts[1]
    gameItems=f
    gameItems.safeTransferFrom(deployerAddress, playerAddress, 2, 1, "0x0")
    print(gameItems.balanceOf(playerAddress, 2),
          gameItems.balanceOf(deployerAddress, 2)
          )

    gameItems.safeBatchTransferFrom(deployerAddress, playerAddress, [0, 1, 3, 4], [50, 100, 1, 1], "0x0")
    result=gameItems.balanceOfBatch([playerAddress, playerAddress, playerAddress, playerAddress, playerAddress],
                               [0, 1, 2, 3, 4])
    print('将项目批量转移到玩家帐户，并获得批次余额', result)
    print('获取元数据uri：', gameItems.uri(2))
    # return f

