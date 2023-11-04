// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";

import {Registry} from "../src/Registry.sol";

contract RegistryDeploy is Script {

    Registry registry;

    uint deployerPrivateKey;
    address initialOwner;

    function setUp() public {
        deployerPrivateKey = vm.envUint("SEPOLIA_DEPLOYER_PRIVATE_KEY");
        initialOwner = vm.envAddress("SEPOLIA_INITIAL_OWNER_ADDRESS");
    }

    function run() public {
        vm.startBroadcast(deployerPrivateKey);
        registry = new Registry(initialOwner);
        vm.stopBroadcast();
    }
}