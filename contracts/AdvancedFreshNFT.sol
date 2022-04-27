// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;

import "@openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@chainlink-brownie-contracts/contracts/src/v0.8/VRFConsumerBase.sol";

contract AdvancedFreshNFT is ERC721URIStorage, VRFConsumerBase{
    uint256 public tokenId;
    bytes32 public keyhash;
    uint256 public fee;
    enum nftType{PUG, SHIBA_INU, BRENARD}
    mapping(bytes32 => address) public requestRandomnessToSender;
    mapping(bytes32 => string) public requestRandomnessToTokenURI;
    mapping(uint256 => nftType) public tokenIdToNftType;
    mapping(bytes32 => uint256) public requestRandomnessToTokenId;
    event requestedFreshNFT( bytes32 indexed request_randomness);
    // _VRFCoordinator takes the address of contract called VRFCoordinator. Which cryptographically checks if the number is truly random.
    // _LinkToken takes the address of Link token. Which helps us to pay oracle for its service
    // _keyhash is used to identify proper oracle 
    constructor(address _VRFCoordinator, address _LinkToken, bytes32 _keyhash)
    public
    VRFConsumerBase(_VRFCoordinator, _LinkToken)
    ERC721("Fresh", "FRE")
    {
        tokenId = 0;
        keyhash = _keyhash;
        fee = 0.1 * 10 * 18; //Setting oracle gas which is usually called as Link Fee
    }

    // As we are working with oracles to get the randomness, so we have to send a request out and we have to define our callback to return
    //it. We have to wait for that oracle to respond.
    /* We'll have TWO FUNCTIONS here*/

    // keyhash + user provided seed, is what the VRF used to cryptographically gurantee that the number is random.
    function createAdvancedFreshNFT( string memory tokenURI)
    public returns(bytes32)
    {
        bytes32 request_randomness = requestRandomness(keyhash, fee);
        requestRandomnessToSender[request_randomness] = msg.sender;
        requestRandomnessToTokenURI[request_randomness] = tokenURI;
        emit requestedFreshNFT(request_randomness);
    }

    function fulfillRandomness(bytes32 request_randomness, uint256 randomNumber) internal override virtual{
        // How if we want to use the randomness here. We have to store it somewhere first. So, we'll create a mapping to do that.
        address freshNftOwner = requestRandomnessToSender[request_randomness];
        string memory tokenURI = requestRandomnessToTokenURI[request_randomness];
        _safeMint(freshNftOwner, tokenId);
        _setTokenURI(tokenId, tokenURI);
        nftType nft_type = nftType( randomNumber % 3);
        tokenIdToNftType[tokenId] = nft_type;
        tokenId+=tokenId;
    }
}