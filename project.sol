// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title DigitalArtGame
 * @dev A smart contract for digital art games with NFT outputs.
 */
contract DigitalArtGame is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;
    mapping(uint256 => address) public creators;

    event ArtCreated(uint256 tokenId, address creator, string tokenURI);

    /**
     * @dev Constructor to initialize the ERC721 and Ownable contracts.
     */
    constructor() ERC721("DigitalArtGame", "DAG") Ownable(msg.sender) {}

    /**
     * @dev Mint a new digital art NFT.
     * @param tokenURI The metadata URI of the digital art.
     */
    function mintArt(string memory tokenURI) public {
        uint256 tokenId = nextTokenId;
        nextTokenId++;
        _safeMint(msg.sender, tokenId); // Mint NFT
        _setTokenURI(tokenId, tokenURI); // Set metadata URI
        creators[tokenId] = msg.sender; // Record creator

        emit ArtCreated(tokenId, msg.sender, tokenURI);
    }

    /**
     * @dev Fetch the creator of a specific token.
     * @param tokenId The ID of the token.
     * @return The address of the creator.
     */
    function getCreator(uint256 tokenId) public view returns (address) {
        return creators[tokenId];
    }

    /**
     * @dev Burn an NFT owned by the caller.
     * @param tokenId The ID of the token to burn.
     */
    function burn(uint256 tokenId) public {
        require(ownerOf(tokenId) == msg.sender, "Not token owner");
        _burn(tokenId);
    }
}
