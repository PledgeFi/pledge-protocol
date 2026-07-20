# Security Policy

## Supported versions

| Version | Supported |
|---|---|
| 1.0.x | Yes |

## Reporting a vulnerability

Email **security@pledge.finance** with reproduction steps, affected chain/address, and impact.

Do not disclose critical issues in public GitHub issues before coordination.

## Scope

Primary audit targets:

- `PledgeVaultManager`
- `PledgeSurplusBuffer`
- `PledgeStabilityPool`
- `VaultMath`

Oracle pricing logic lives in [`pledge-oracle`](../pledge-oracle). Review both repos together for end-to-end CDP safety.

## Known testnet components

`PledgeStaking`, `PledgeTestnetBridge`, and mock ERC20 tokens are not intended for mainnet deployment.
