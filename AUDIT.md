# Audit Scope — pledge-protocol v1.0.0

## In scope (mainnet)

| File | Lines of concern |
|---|---|
| `src/core/PledgeVaultManager.sol` | CDP lifecycle, LTV, liquidation, interest accrual |
| `src/core/PledgeSurplusBuffer.sol` | Fee custody |
| `src/core/PledgeStabilityPool.sol` | USDG backstop (if enabled on mainnet) |
| `src/libraries/VaultMath.sol` | HF, collateral valuation, interest math |

## Out of scope (testnet / auxiliary)

| File | Reason |
|---|---|
| `src/core/PledgeStaking.sol` | Testnet incentives |
| `src/core/PledgeTestnetBridge.sol` | Testnet ingress only |
| `src/mocks/MockERC20.sol` | Test token faucet |
| `script/*` | Deployment scripts |

## External dependencies

| Dependency | Repo | Risk |
|---|---|---|
| `IOracle` | `pledge-oracle` | Price manipulation, staleness |
| OpenZeppelin v5.0.2 | `Ownable`, `ReentrancyGuard`, `SafeERC20` | Standard library |
| USDG (mainnet) | Paxos `0x5fc5…d168` | External stablecoin |

## Key invariants

1. **Solvency:** Vault USDG balance ≥ sum of outstanding debt (modulo liquidity funding model).
2. **LTV:** `borrow` reverts when post-borrow debt exceeds `maxLtvBps` of collateral USD value.
3. **Health factor:** `withdraw` reverts when HF < 1e18 at `liqRatioBps`.
4. **Liquidation:** Positions with HF < 1e18 are liquidatable; liquidator repays full debt for collateral + bonus.
5. **Interest:** Linear APR accrual matches `VaultMath.accrueInterest` (no compounding within accrual tick).
6. **Reentrancy:** All state-changing user paths guarded by `nonReentrant`.

## Known limitations (documented, not bugs)

- Isolated markets per collateral token (no cross-collateralization).
- Owner can pause markets via `setMarketActive(false)`.
- Owner can rotate oracle per market via `setMarketOracle`.
- `fundLiquidity` requires external USDG seeding — no on-chain mint hook.

## Related repositories

Review together with [`pledge-oracle`](../pledge-oracle/AUDIT.md).
