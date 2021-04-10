// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "./HarityFactory.sol";

contract Harity is HarityFactory, ERC721, ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;

    constructor() ERC721("harity", "HRTY") {}

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function createToken() public onlyOwner returns (uint256) {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        //_setTokenURI(newItemId, tokenURI);

        return newItemId;
    }

    // TODO
    /*
    function retrieve(uint256 randomNumber) public returns (string memory) {
        // The id of the token to mint
        uint256 id = numTokens + 1;
        // Draw using randomNumber to select art emoji
        string memory result = _draw(id, randomNumber);

        // Increment numTokens counter because it has been issued another one
        numTokens++;

        // Return the result
        return result;
    }*/
}
