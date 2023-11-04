// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Registry } from "./Registry.sol";
import { Ownable } from "@openzeppelin/access/Ownable.sol";

error BadCommitment();
error StandingCommitment();

contract Vault is Ownable{
    Registry public registry;

    mapping(uint256 => bytes32) public commitments;

    constructor(
      address owner_
    ) Ownable(owner_) {
        registry = new Registry({
            owner_: address(this)
        });
    }

    function mint(uint256 cellphone,bytes32 commitment,bytes memory data) onlyOwner external {
        commitments[cellphone] = commitment;
        registry.mint(address(this), cellphone, data);
    }

    function burn(uint256 cellphone) onlyOwner external {
        if(commitments[cellphone] == bytes32(0)) {
            revert StandingCommitment();
        }
        registry.burn(cellphone);
    }

    function transfer(uint256 cellphone,bytes32 newCommitment) external {
        if(commitments[cellphone] != createCommitment({
            owner : msg.sender,
            cellphone : cellphone
        })) {
            revert StandingCommitment();
        }
        commitments[cellphone] = newCommitment;
    }

    function withdraw(address to,uint256 cellphone) external {
        if(commitments[cellphone] != createCommitment({
            owner : msg.sender,
            cellphone : cellphone
        })) {
            revert StandingCommitment();
        }
        commitments[cellphone] = bytes32(0);

        registry.safeTransferFrom({
          from : address(this),
          to : to,
          tokenId : cellphone
        });
    }

    function deposit(uint256 cellphone,bytes32 commitment) external payable {
        commitments[cellphone] = commitment;

        registry.safeTransferFrom({
          from : msg.sender,
          to : address(this),
          tokenId : cellphone
        });
    }

    function createCommitment(address owner,uint cellphone) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(owner,cellphone));
    }
}