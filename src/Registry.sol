// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


import { ERC721 } from "@openzeppelin/token/ERC721/ERC721.sol";
import { Ownable } from "@openzeppelin/access/Ownable.sol";

contract Registry is ERC721,Ownable {
    constructor(
      address owner_
    ) ERC721("Cell-Phone-Registry","CPR") Ownable(owner_) {}

    function mint(address to, uint256 tokenId,bytes memory data) onlyOwner external {
        _safeMint(to, tokenId, data);
    }

    function burn(uint256 tokenId) onlyOwner external {
        _burn(tokenId);
    }
}