from brownie import freshNFT, config, accounts, network;
import os;


def deploy_fresh_nft():
    account = accounts.add(os.getenv(config["wallets"]["from_key"]));
    print(network.show_active());
    # fresh_nft = freshNFT[len(freshNFT) - 1];
    # print(freshNFT.ownerOf);
    return freshNFT.deploy({'from': account});
    



def main():
    deploy_fresh_nft();