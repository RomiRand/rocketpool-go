#!/usr/bin/env bash

# Exit if a command fails
set -o errexit


##
# Config
##


# Rocket Pool settings
rp_repo_url="https://github.com/rocket-pool/rocketpool.git"
rp_repo_branch="v2.5-Tokenomics-updates"

# Dependencies

# Ganache settings
ganache_gas_limit="12450000"
ganache_eth_balance="1000000"
ganache_mnemonic="jungle neck govern chief unaware rubber frequent tissue service license alcohol velvet"
ganache_port="8545"


##
# Helpers
##


# Clean up
cleanup() {

    # Remove RP repo
    if [ -d "$rp_tmp_path" ]; then
        rm -rf "$rp_tmp_path"
    fi

    # Kill ganache instance
    if [ -n "$ganache_pid" ] && ps -p "$ganache_pid" > /dev/null; then
        kill -9 "$ganache_pid"
    fi

}

# Clone Rocket Pool repo
clone_rp() {
    rp_tmp_path="$(mktemp -d)"
    rp_path="$rp_tmp_path/rocketpool"
    git clone "$rp_repo_url" -b "$rp_repo_branch" "$rp_path"
}

# Install Rocket Pool dependencies
install_rp_deps() {
    cd "$rp_path"
    rm package.json package-lock.json
    npm install \
        babel-register \
        babel-polyfill \
        web3@1.2.8 \
        ganache-cli@6.12.2 \
        truffle@5.1.66 \
        truffle-contract@4.0.31 \
        @openzeppelin/contracts@3.3.0 \
        pako@1.0.11
    cd - > /dev/null
}

# Start ganache-cli instance
start_ganache() {
    cd "$rp_path"
    node_modules/.bin/ganache-cli -l "$ganache_gas_limit" -e "$ganache_eth_balance" -m "$ganache_mnemonic" -p "$ganache_port" > /dev/null &
    ganache_pid=$!
    cd - > /dev/null
}

# Migrate Rocket Pool contracts
migrate_rp() {
    cd "$rp_path"
    node_modules/.bin/truffle migrate
    cd - > /dev/null
}


##
# Run
##


# Clean up before exiting
trap cleanup EXIT

# Clone RP repo
echo ""
echo "Cloning main Rocket Pool repository..."
echo ""
clone_rp

# Install RP deps
echo ""
echo "Installing Rocket Pool dependencies..."
echo ""
install_rp_deps

# Start ganache
echo ""
echo "Starting ganache-cli process..."
echo ""
start_ganache

# Migrate RP contracts
echo ""
echo "Migrating Rocket Pool contracts..."
echo ""
migrate_rp
