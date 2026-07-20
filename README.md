# pledge-protocol

CDP vault protocol for Pledge Finance on Robinhood Chain — deposit tokenized equities, borrow USDG.

Depends on [`pledge-oracle`](https://github.com/pledge-finance/pledge-oracle) for collateral pricing via `IOracle`.

## Stack

- Foundry, Solidity 0.8.24
- OpenZeppelin Contracts v5
- Robinhood Testnet `46630` · Mainnet `4663`

## Contracts

| Contract | Role |
|---|---|
| `PledgeVaultManager` | Isolated CDP vaults — deposit, borrow, repay, liquidate |
| `PledgeSurplusBuffer` | Protocol fee treasury (USDG) |
| `PledgeStabilityPool` | USDG liquidation backstop |
| `PledgeStaking` | Testnet reward staking |
| `PledgeTestnetBridge` | Testnet cross-chain ingress (EIP-712 attestation) |
| `VaultMath` | Health factor, LTV, interest accrual |

## Setup

```bash
git submodule update --init --recursive
forge install foundry-rs/forge-std OpenZeppelin/openzeppelin-contracts --no-commit
cp .env.example .env
```

If not using submodules, symlink or clone `pledge-oracle` into `lib/pledge-oracle` (see `foundry.toml` remappings).

## Test

```bash
forge test -vv
```

## Deploy testnet

```bash
forge script script/Deploy.s.sol \
  --rpc-url $ROBINHOOD_TESTNET_RPC \
  --broadcast \
  --chain-id 46630
```

Post-deploy: fund vault liquidity, register markets (`AddMarkets.s.sol`), configure oracle via `pledge-oracle`.

## Deploy mainnet

```bash
forge script script/DeployMainnet.s.sol \
  --rpc-url $ROBINHOOD_MAINNET_RPC \
  --broadcast \
  --chain-id 4663

forge script script/RegisterMainnetMarkets.s.sol \
  --rpc-url $ROBINHOOD_MAINNET_RPC \
  --broadcast \
  --chain-id 4663
```

Mainnet uses Paxos USDG (`0x5fc5…d168`) and `PledgeChainlinkOracle`.

## Risk parameters (defaults)

| Market | Max LTV | Liq. ratio |
|---|---|---|
| NVDA | 60% | 166% |
| AAPL / MSFT | 65% | 153% |
| SPY | 75% | 133% |
| QQQ | 70% | 143% |
| AMZN | 58% | 172% |
| META | 62% | 161% |

## Audit scope

- `src/core/PledgeVaultManager.sol`
- `src/core/PledgeSurplusBuffer.sol`
- `src/core/PledgeStabilityPool.sol`
- `src/libraries/VaultMath.sol`

Testnet-only (`PledgeStaking`, `PledgeTestnetBridge`, `src/mocks/`) excluded from mainnet deployment review.
