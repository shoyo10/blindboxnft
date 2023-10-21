// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BlindBoxNft is ERC721, Ownable {
    uint256 private _tokenId = 1;
    uint256 public totalSupply;
    address private _owner;
    bool private _blindBoxStatus = false;
    string private _tokenURI;
    string private _blindURI = "ipfs://QmQKHTePSDpR68iUvSk6vrGg3wCN1d2WvXE9jG1rwqfPwb/0";

    constructor(address initialOwner, uint256 _totalSupply) ERC721("blind box NFT", "BBNFT") Ownable(initialOwner) {
        totalSupply = _totalSupply;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);

        if (_blindBoxStatus) {
            return _tokenURI;
        } 
        return _blindURI;
    }

    function setTokenURI(string calldata _uri) external onlyOwner {
        _tokenURI = _uri;
    }

    function getTokenURI() external view onlyOwner returns (string memory) {
        return _tokenURI;
    }

    function setBlindBoxStatus(bool status) external onlyOwner {
        _blindBoxStatus = status;
    }

    function getBlindBoxStatus() external view onlyOwner returns (bool) {
        return _blindBoxStatus;
    }

    function mint(address to) public returns (uint256) {
        require(_tokenId <= totalSupply, "mint: total supply reached");

        uint256 mintedTokenId = _tokenId;
        _tokenId++;
        _mint(to, mintedTokenId);
        return mintedTokenId;
    }

    function getTotalSupply() external view returns (uint256) {
        return totalSupply;
    }
}