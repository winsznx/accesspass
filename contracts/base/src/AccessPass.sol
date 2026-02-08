// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title AccessPass
 * @notice NFT-based membership with tiered access
 */
contract AccessPass {
    error NotAuthorized();
    error InvalidTier();
    error AlreadyMinted();

    event PassMinted(address indexed holder, uint256 tier, uint256 tokenId);
    event TierUpgraded(address indexed holder, uint256 newTier);

    struct Pass {
        uint256 tier;
        uint256 mintedAt;
        bool active;
    }

    mapping(address => Pass) public passes;
    mapping(address => bool) public admins;
    uint256 public tokenCounter;

    constructor() {
        admins[msg.sender] = true;
    }

    function mint(address to, uint256 tier) external {
        if (!admins[msg.sender]) revert NotAuthorized();
        if (tier == 0 || tier > 3) revert InvalidTier();
        if (passes[to].active) revert AlreadyMinted();
        
        passes[to] = Pass({
            tier: tier,
            mintedAt: block.timestamp,
            active: true
        });
        emit PassMinted(to, tier, tokenCounter++);
    }

    function upgrade(address holder, uint256 newTier) external {
        if (!admins[msg.sender]) revert NotAuthorized();
        if (newTier <= passes[holder].tier) revert InvalidTier();
        passes[holder].tier = newTier;
        emit TierUpgraded(holder, newTier);
    }

    function hasAccess(address user, uint256 requiredTier) external view returns (bool) {
        return passes[user].active && passes[user].tier >= requiredTier;
    }

    function getPass(address holder) external view returns (uint256, uint256, bool) {
        Pass memory p = passes[holder];
        return (p.tier, p.mintedAt, p.active);
    }
}
