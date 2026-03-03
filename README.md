# Simple Crypto Vault (Time-Lock)

This repository features a high-quality, flat-structured Time-Lock vault. It allows users to deposit ETH or native tokens that cannot be withdrawn until a specified timestamp has passed. Perfect for long-term savers or "HODLers."

## Features
* **Secure Locking:** Funds are cryptographically locked until the release time.
* **Individual Vaults:** Each address manages its own unique lock time and balance.
* **Safety Checks:** Prevents withdrawals before the unlock date is reached.
* **Transparent Logic:** Easy to verify the release time on any block explorer.

## Getting Started
1. Open [Remix IDE](https://remix.ethereum.org/).
2. Deploy `CryptoVault.sol`.
3. Call `deposit` with a `releaseTime` (Unix Timestamp) and send some ETH.
4. Once the time passes, call `withdraw` to reclaim your funds.

## License
MIT
