// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract NftMint {
    using SafeMath for uint;

    // The total supply of the NFT
    uint public totalSupply;

    // The balance of each address
    mapping(address => uint) public balanceOf;

    // The minter of the NFT
    address public minter;

    // The NFTs owned by each address
    mapping(address => mapping(uint => bool)) public ownedBy;

    // The metadata for each NFT
    mapping(uint => string) public metadata;

    // Events
    event Mint(address indexed _to, uint _id);
    event Transfer(address indexed _from, address indexed _to, uint _id);

    // Constructor
    constructor() {
        // Set the total supply and the minter
        totalSupply = 0;
        minter = msg.sender;
    }

    // Mint function
    function mint(address _to, string memory _metadata) public {
        // Only the minter can mint new NFTs
        require(msg.sender == minter, "Only the minter can mint NFTs");

        // Increment the total supply and set the owner of the new NFT
        totalSupply = totalSupply.add(1);
        ownedBy[_to][totalSupply] = true;

        // Set the metadata for the new NFT
        metadata[totalSupply] = _metadata;

        // Increment the balance of the recipient
        balanceOf[_to] = balanceOf[_to].add(1);

        // Emit the Mint event
        emit Mint(_to, totalSupply);
    }

    // Transfer function
    function transfer(address _to, uint _id) public {
        // Ensure that the caller owns the NFT and the recipient is valid
        require(ownedBy[msg.sender][_id], "NFT not owned by caller");
        require(_to != address(0), "Invalid recipient");

        // Transfer ownership of the NFT
        ownedBy[msg.sender][_id] = false;
        ownedBy[_to][_id] = true;

        // Increment the balance of the recipient and decrement the balance of the sender
        balanceOf[_to] = balanceOf[_to].add(1);
        balanceOf[msg.sender] = balanceOf[msg.sender].sub(1);

        // Emit the Transfer event
        emit Transfer(msg.sender, _to, _id);
    }
}