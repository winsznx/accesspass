# AccessPass

NFT-based membership system with tiered benefits on Base and Stacks blockchains.

## Features

- Mint membership NFTs with tier levels
- Tiered access control (Bronze, Silver, Gold)
- Upgrade membership tiers
- Admin-controlled issuance
- Multi-chain membership

## Smart Contract Functions

### Base (Solidity)
- `mint(address to, uint256 tier)` - Mint membership pass
- `upgrade(address holder, uint256 newTier)` - Upgrade tier
- `hasAccess(address user, uint256 requiredTier)` - Check access
- `getPass(address holder)` - Get pass details

### Stacks (Clarity)
- `(mint (to principal) (tier uint))` - Mint pass
- `(has-access (user principal) (required-tier uint))` - Check access
- `(get-pass (holder principal))` - Get pass info

## Tech Stack

- **Frontend**: Next.js 14, TypeScript, Tailwind CSS
- **Base**: Solidity 0.8.20, Foundry, Reown wallet
- **Stacks**: Clarity v4, Clarinet, @stacks/connect

## Getting Started

```bash
pnpm install
pnpm dev
```

## License

MIT License
