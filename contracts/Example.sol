pragma solidity ^0.4.24;

interface ERC721TokenReceiver {
    function onERC721Received(
        address _operator,
        address _from,
        uint256 _tokenId,
        bytes _data
    ) external returns (bytes4);
}

contract Example {
    event Generated(uint256 indexed index, address indexed a, string value);

    bytes4 internal constant MAGIC_ON_ERC721_RECEIVED = 0x150b7a02;

    uint256 public constant TOKEN_LIMIT = 512; // 8 for testing, 256 or 512 for prod;
    uint256 public constant ARTIST_PRINTS = 128; // 2 for testing, 64 for prod;

    uint256 public constant PRICE = 200 finney;

    // The beneficiary is 350.org
    address public constant BENEFICIARY =
        0x50990F09d4f0cb864b8e046e7edC749dE410916b;

    mapping(uint256 => address) private idToCreator;
    mapping(uint256 => uint8) private idToSymbolScheme;

    /**
     * @dev A mapping from NFT ID to the address that owns it.
     */
    mapping(uint256 => address) internal idToOwner;

    /**
     * @dev A mapping from NFT ID to the seed used to make it.
     */
    mapping(uint256 => uint256) internal idToSeed;
    mapping(uint256 => uint256) internal seedToId;

    /**
     * @dev Mapping from NFT ID to approved address.
     */
    mapping(uint256 => address) internal idToApproval;

    /**
     * @dev Mapping from owner address to mapping of operator addresses.
     */
    mapping(address => mapping(address => bool)) internal ownerToOperators;

    /**
     * @dev Mapping from owner to list of owned NFT IDs.
     */
    mapping(address => uint256[]) internal ownerToIds;

    /**
     * @dev Mapping from NFT ID to its index in the owner tokens list.
     */
    mapping(uint256 => uint256) internal idToOwnerIndex;

    /**
     * @dev Total number of tokens.
     */
    uint256 internal numTokens = 0;

    ///////////////////
    //// GENERATOR ////
    ///////////////////

    /* * ** *** ***** ******** ************* ******** ***** *** ** * */

    // The following code generates art.

    function draw(uint256 id) public view returns (string) {
        uint256 a = uint256(uint160(keccak256(abi.encodePacked(idToSeed[id]))));
        bytes memory output = new bytes(USIZE * (USIZE + 3) + 30);
        uint256 c;
        for (c = 0; c < 30; c++) {
            output[c] = prefix[c];
        }
        int256 x = 0;
        int256 y = 0;
        uint256 v = 0;
        uint256 value = 0;
        uint256 mod = (a % 11) + 5;
        bytes5 symbols;
        if (idToSymbolScheme[id] == 0) {
            revert();
        } else if (idToSymbolScheme[id] == 1) {
            symbols = 0x2E582F5C2E; // X/\
        } else if (idToSymbolScheme[id] == 2) {
            symbols = 0x2E2B2D7C2E; // +-|
        } else if (idToSymbolScheme[id] == 3) {
            symbols = 0x2E2F5C2E2E; // /\
        } else if (idToSymbolScheme[id] == 4) {
            symbols = 0x2E5C7C2D2F; // \|-/
        } else if (idToSymbolScheme[id] == 5) {
            symbols = 0x2E4F7C2D2E; // O|-
        } else if (idToSymbolScheme[id] == 6) {
            symbols = 0x2E5C5C2E2E; // \
        } else if (idToSymbolScheme[id] == 7) {
            symbols = 0x2E237C2D2B; // #|-+
        } else if (idToSymbolScheme[id] == 8) {
            symbols = 0x2E4F4F2E2E; // OO
        } else if (idToSymbolScheme[id] == 9) {
            symbols = 0x2E232E2E2E; // #
        } else {
            symbols = 0x2E234F2E2E; // #O
        }
        for (int256 i = int256(0); i < SIZE; i++) {
            y = (2 * (i - HALF_SIZE) + 1);
            if (a % 3 == 1) {
                y = -y;
            } else if (a % 3 == 2) {
                y = abs(y);
            }
            y = y * int256(a);
            for (int256 j = int256(0); j < SIZE; j++) {
                x = (2 * (j - HALF_SIZE) + 1);
                if (a % 2 == 1) {
                    x = abs(x);
                }
                x = x * int256(a);
                v = uint256((x * y) / ONE) % mod;
                if (v < 5) {
                    value = uint256(symbols[v]);
                } else {
                    value = 0x2E;
                }
                output[c] = bytes1(bytes32(value << 248));
                c++;
            }
            output[c] = bytes1(0x25);
            c++;
            output[c] = bytes1(0x30);
            c++;
            output[c] = bytes1(0x41);
            c++;
        }
        string memory result = string(output);
        return result;
    }

    /* * ** *** ***** ******** ************* ******** ***** *** ** * */

    function creator(uint256 _id) external view returns (address) {
        return idToCreator[_id];
    }

    function symbolScheme(uint256 _id) external view returns (uint8) {
        return idToSymbolScheme[_id];
    }

    function createGlyph(uint256 seed) external payable returns (string) {
        return _mint(msg.sender, seed);
    }

    /**
     * @dev Mints a new NFT.
     * @notice This is an internal function which should be called from user-implemented external
     * mint function. Its purpose is to show and properly initialize data structures when using this
     * implementation.
     * @param _to The address that will own the minted NFT.
     */
    function _mint(address _to, uint256 seed) internal returns (string) {
        require(_to != address(0));
        require(numTokens < TOKEN_LIMIT);
        uint256 amount = 0;
        if (numTokens >= ARTIST_PRINTS) {
            amount = PRICE;
            require(msg.value >= amount);
        }
        require(seedToId[seed] == 0);
        uint256 id = numTokens + 1;

        idToCreator[id] = _to;
        idToSeed[id] = seed;
        seedToId[seed] = id;
        uint256 a = uint256(uint160(keccak256(abi.encodePacked(seed))));
        idToSymbolScheme[id] = getScheme(a);
        string memory uri = draw(id);
        emit Generated(id, _to, uri);

        numTokens = numTokens + 1;
        _addNFToken(_to, id);

        if (msg.value > amount) {
            msg.sender.transfer(msg.value - amount);
        }
        if (amount > 0) {
            BENEFICIARY.transfer(amount);
        }

        emit Transfer(address(0), _to, id);
        return uri;
    }

    //// Enumerable

    function totalSupply() public view returns (uint256) {
        return numTokens;
    }

    function tokenByIndex(uint256 index) public view returns (uint256) {
        require(index < numTokens);
        return index;
    }

    /**
     * @dev returns the n-th NFT ID from a list of owner's tokens.
     * @param _owner Token owner's address.
     * @param _index Index number representing n-th token in owner's list of tokens.
     * @return Token id.
     */
    function tokenOfOwnerByIndex(address _owner, uint256 _index)
        external
        view
        returns (uint256)
    {
        require(_index < ownerToIds[_owner].length);
        return ownerToIds[_owner][_index];
    }

    //// Metadata

    /**
     * @dev Returns a descriptive name for a collection of NFTokens.
     * @return Representing name.
     */
    function name() external view returns (string memory _name) {
        _name = nftName;
    }

    /**
     * @dev Returns an abbreviated name for NFTokens.
     * @return Representing symbol.
     */
    function symbol() external view returns (string memory _symbol) {
        _symbol = nftSymbol;
    }

    /**
     * @dev A distinct URI (RFC 3986) for a given NFT.
     * @param _tokenId Id for which we want uri.
     * @return URI of _tokenId.
     */
    function tokenURI(uint256 _tokenId)
        external
        view
        validNFToken(_tokenId)
        returns (string memory)
    {
        return draw(_tokenId);
    }
}
