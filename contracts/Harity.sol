// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@chainlink/contracts/src/v0.8/dev/VRFConsumerBase.sol";

import "./HarityFactory.sol";

contract Harity is
    HarityFactory,
    VRFConsumerBase,
    ERC721,
    ERC721Enumerable,
    ERC721URIStorage,
    Ownable
{
    using Counters for Counters.Counter;

    // The maximum number of token that can be created, 1 for each emoji in the dictionary
    uint16 public constant TOKEN_LIMIT = 948;

    // Chainlink needed variables
    bytes32 internal linkKeyHash;
    uint256 internal linkFee;

    // A counter with all the ids of minted tokens
    Counters.Counter private _tokenIds;

    // TODO: Network -> Kovan
    constructor()
        VRFConsumerBase(
            0xdD3782915140c8f3b190B5D67eAc6dc5760C46E9, // VRF Coordinator
            0xa36085F69e2889c224210F603D836748e7dC0088 // LINK Token
        )
        ERC721("harity", "HRTY")
    {
        // Set initial link data
        linkKeyHash = 0x6c3699283bda56ad74f6b855546325b68d482e983852a7a82979cc4807b641f4;
        // 0.1 LINK (varies by network)
        linkFee = 0.1 * 10**18;
    }

    /// Requests randomness to mint a new token, when the request is fulfilled a new token is minted
    function requestMint() public onlyOwner returns (bytes32 requestId) {
        require(LINK.balanceOf(address(this)) >= linkFee, "Not enough LINK");

        // Limit minting to a maximum of 948 tokens to be sure that at least every emoji is in an artwork
        uint256 numTokens = _tokenIds.current();
        require(numTokens < TOKEN_LIMIT);

        // The seed to request randomness is the id of the next token to be minted
        // It's useless, it's just used for API compatibility (as docs said)
        uint256 seed = numTokens + 1;
        // Request randomness to VRF coordinator using new token id as seed
        return requestRandomness(linkKeyHash, linkFee, seed);
    }

    /// Withdraw LINK from the contract if in excess, it needs to be used for VRF call fee management
    function withdrawLink() external onlyOwner {
        require(
            LINK.transfer(owner(), LINK.balanceOf(address(this))),
            "Unable to transfer LINK"
        );
    }

    /// Modify link key hash value
    function setLinkKeyHash(bytes32 _linkKeyHash) external onlyOwner {
        linkKeyHash = _linkKeyHash;
    }

    /// Modify link fee value
    function setLinkFee(uint256 _linkFee) external onlyOwner {
        linkFee = _linkFee;
    }

    /// Callback function used by VRF Coordinator that mints a new token from randomness
    function fulfillRandomness(bytes32 requestId, uint256 randomness)
        internal
        override
    {
        // Increment the number of tokens and get the id of the new one to be minted
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        // Generate the art through token id and a real verifiable random number
        string memory uri = _draw(newTokenId, randomness);

        // Mint the new token to the owner using ERC721 contract internal method
        _mint(owner(), newTokenId);
        // Set the created artwork string as token uri to store the art internally
        _setTokenURI(newTokenId, uri);
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
