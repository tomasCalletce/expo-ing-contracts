// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC721} from "@solmate-tokens/ERC721.sol";

contract Registry is ERC721 {

    uint name;

    constructor(uint name_) ERC721("Registry", "REG") {
      name = name_;
    }
}