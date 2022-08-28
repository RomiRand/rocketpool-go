## rocketpool-go/test.sh
- why is there a azure repo I've no access? Isn't this the normal rp repo? `rp_repo_url="git@ssh.dev.azure.com:v3/rocket-pool/RocketPool/rocketpool"`
- truffle error: `Unknown network "localhost". See your Truffle configuration file for available networks.` -> use network `development` I guess?

- testutils/accounts/accounts.go: Use NewKeyedTransactorWithChainID
- update ganache to fix `invalid remainder`, using the new package `ganache` instead of `ganache-cli`
- max/baseFeePerGas of 0 causes the tx to fail in utils/eth/transactions.go, for local testnetwork at least. Is this because of missing/wrong estimation? Suggest adding the estimation. There are some open issues for this, e.g. see https://github.com/trufflesuite/ganache/issues/1573. Should query baseFeePerGas of last block and not vary more than 12.5%; usually would query `eth_feeHistory` for that info. But that PR is still open (https://github.com/trufflesuite/ganache/pull/3351), so hardcoding it for now.
- the abi of `rocketMinipoolFactory` is not saved in rocketStorage?