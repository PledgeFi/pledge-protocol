# Changelog

All notable changes to this project are documented here.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.0.0] - 2026-07-20

### Added

- `PledgeVaultManager` — isolated CDP vaults on Robinhood Chain
- `PledgeSurplusBuffer` — protocol fee treasury
- `PledgeStabilityPool` — USDG liquidation backstop
- `VaultMath` — health factor and interest helpers
- Testnet modules: `PledgeStaking`, `PledgeTestnetBridge`, `MockERC20`
- Foundry scripts for testnet and mainnet deployment
- Integration tests against `pledge-oracle`
- CI: build, test, fmt check

[1.0.0]: https://github.com/pledge-finance/pledge-protocol/releases/tag/v1.0.0
