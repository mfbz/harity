// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "./HarityFactory.sol";

// TODO:
// - Add chainlink contract and implementation
// - Add withdraw function to the contract for both eth and link
// - Complete _draw function in HarityFactory
contract Harity is
    HarityFactory,
    ERC721,
    ERC721Enumerable,
    ERC721URIStorage,
    Ownable
{
    using Counters for Counters.Counter;

    // The maximum number of token that can be created, 1 for each emoji in the dictionary
    uint16 public constant TOKEN_LIMIT = 948;

    // A counter with all the ids of minted tokens
    Counters.Counter private _tokenIds;

    constructor() ERC721("harity", "HRTY") {}

    // Only the owner of the contract can mint a new token
    function mint() public onlyOwner returns (uint256) {
        // Limit minting to a maximum of 948 tokens to be sure that at least every emoji is
        // represented in an artwork
        uint256 numTokens = _tokenIds.current();
        require(numTokens < TOKEN_LIMIT);

        // Increment the number of tokens and get the id of the new one to be minted
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        // TODO: Generate the art through token id and a real verifiable random number
        string memory uri = _draw(newTokenId, 99999999999);

        // Mint the new token using ERC721 contract internal
        _mint(msg.sender, newTokenId);
        // Set the created artwork string as token uri to store the art internally
        _setTokenURI(newTokenId, uri);

        // Return the id of the newly minted token
        return newTokenId;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
