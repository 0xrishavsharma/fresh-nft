from brownie import FreshNFT, config, accounts, network;
import os;


def deploy_fresh_nft():
    account = accounts.add(os.getenv(config["wallets"]["from_key"]));
    print(network.show_active());
    # fresh_nft = FreshNFT[len(FreshNFT) - 1];
    # print(FreshNFT.ownerOf);
    return FreshNFT.deploy({'from': account});
    



def main():
    deploy_fresh_nft();