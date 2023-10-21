// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Test, Vm} from "forge-std/Test.sol";
import {BlindBoxNft} from "../src/BlindBoxNft.sol";

contract BlindBoxNftTest is Test {
    BlindBoxNft public bbnft;
    address public owner = makeAddr("owner");
    address public user1;
    address public user2;
    uint256 public totalSupply = 500;
    string blindboxURI = "ipfs://QmQKHTePSDpR68iUvSk6vrGg3wCN1d2WvXE9jG1rwqfPwb/0";

    function setUp() public {
        bbnft = new BlindBoxNft(owner, totalSupply);
        user1 = makeAddr("user1");
        user2 = makeAddr("user2");
    }

    function test_tokenURI() public {
        uint256 tokenId1 = bbnft.mint(user1);
        assertEq(1, tokenId1);
        assertEq(blindboxURI, bbnft.tokenURI(tokenId1));

        uint256 tokenId2 = bbnft.mint(user2);
        assertEq(2, tokenId2);
        assertEq(blindboxURI, bbnft.tokenURI(tokenId2));

        vm.expectRevert();
        bbnft.tokenURI(3);
    }

    function test_setTokenURI() public {
        string memory tokenURI = "ipfs://QmQKHTePSDpR68iUvSk6vrGg3wCN1d2WvXE9jG1rwqfPwb/1";
        vm.expectRevert();
        bbnft.setTokenURI(tokenURI);

        vm.expectRevert();
        bbnft.getTokenURI();

        vm.startPrank(owner);

        assertEq("", bbnft.getTokenURI());
        bbnft.setTokenURI(tokenURI);
        assertEq(tokenURI, bbnft.getTokenURI());

        vm.stopPrank();
    }

    function test_setBlindBoxStatus() public {
        string memory tokenURI = "ipfs://QmQKHTePSDpR68iUvSk6vrGg3wCN1d2WvXE9jG1rwqfPwb/1";

        uint256 tokenId1 = bbnft.mint(user1);

        // 解盲前
        assertEq(blindboxURI, bbnft.tokenURI(tokenId1));

        vm.expectRevert();
        bbnft.setBlindBoxStatus(true);

        vm.expectRevert();
        bbnft.getBlindBoxStatus();

        vm.startPrank(owner);

        assertEq(false, bbnft.getBlindBoxStatus());
        bbnft.setBlindBoxStatus(true);
        assertEq(true, bbnft.getBlindBoxStatus());

        bbnft.setTokenURI(tokenURI);

        vm.stopPrank();

        // 解盲後
        assertEq(tokenURI, bbnft.tokenURI(tokenId1));
    }

    function test_totalSupply() public {
        assertEq(totalSupply, bbnft.getTotalSupply());

        bbnft = new BlindBoxNft(owner, 2);
        assertEq(2, bbnft.getTotalSupply());

        bbnft.mint(user1);
        bbnft.mint(user1);

        vm.expectRevert("mint: total supply reached");
        bbnft.mint(user1);
    }
}