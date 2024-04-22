#!/usr/bin/env bash

furyad10 query bank balances $(furyad10 keys show -a validator --keyring-backend=test)
furyad10 tx mint burn-tokens 500000000stake --keyring-backend=test --from=validator --chain-id=testing --home=$HOME/.furyad10/ --yes  --broadcast-mode=block
furyad10 query bank balances $(furyad10 keys show -a validator --keyring-backend=test)
