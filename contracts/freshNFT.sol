// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;

import '@openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol';

contract freshNFT is ERC721URIStorage{
    
    uint256 public tokenId;

    constructor() ERC721("Fresh", "FRE"){
        tokenId = 0;
    }

    function mintFresh(string memory tokenURI) public returns(uint256) {
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);
        tokenId+=tokenId;
        return tokenId;
    }
}