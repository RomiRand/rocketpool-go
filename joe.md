## rocketpool-go/test.sh
- why is there a azure repo I've no access? Isn't this the normal rp repo? `rp_repo_url="git@ssh.dev.azure.com:v3/rocket-pool/RocketPool/rocketpool"`
- truffle error: `Unknown network "localhost". See your Truffle configuration file for available networks.` -> use network `development` I guess?

- testutils/accounts/accounts.go: Use NewKeyedTransactorWithChainID
- update ganache to fix `invalid remainder`, using the new package `ganache` instead of `ganache-cli`