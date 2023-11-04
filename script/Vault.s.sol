// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";

import {Vault} from "../src/Vault.sol";

contract VaultDeploy is Script {

    Vault vault;

    uint deployerPrivateKey;
    address initialOwner;

    function setUp() public {
        deployerPrivateKey = vm.envUint("SEPOLIA_DEPLOYER_PRIVATE_KEY");
        initialOwner = vm.envAddress("SEPOLIA_INITIAL_OWNER_ADDRESS");
    }

    function run() public {
        vm.startBroadcast(deployerPrivateKey);
        vault = new Vault(initialOwner);
        vm.stopBroadcast();
    }
}