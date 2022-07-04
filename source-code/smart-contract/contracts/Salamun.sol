// contract/Salamun.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract Salamun is ERC721Enumerable, Ownable{
    uint256 public constant MAX_SUPPLY = 20;
    string private _baseTokenURI;
    bytes32 public merkleRoot;

    constructor() ERC721("Salamun","SAL"){

    }

    function _baseURI() internal view virtual override returns(string memory){
        return _baseTokenURI;
    }

    function setBaseURI(string calldata baseURI_) external onlyOwner {
        _baseTokenURI = baseURI_;
    }

    function setMerkleRoot(bytes32 merkleRoot_) external onlyOwner {
        merkleRoot = merkleRoot_;
    }

    function mint(uint256 quantity_) external payable {
        require(totalSupply() + quantity_ <= MAX_SUPPLY, 'Max supply sudah terpenuhi');

        for(uint256 i = 1;i <= quantity_;i ++){
            _safeMint(msg.sender, totalSupply() + 1);
        }
    }

    function mintWhitelist(uint256 quantity_,bytes32[] memory proof_) external payable {
        require(MerkleProof.verify(proof_, merkleRoot, keccak256(abi.encodePacked(msg.sender))),"You are not whitelisted!");
        require(totalSupply() + quantity_ <= MAX_SUPPLY, 'Max supply sudah terpenuhi');

        for(uint256 i = 1;i <= quantity_;i ++){
            _safeMint(msg.sender, totalSupply() + 1);
        }
    }

}