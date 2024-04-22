#!/bin/bash

rm -rf $HOME/.furyad10/

cd $HOME

furyad10131 init --chain-id=testing testing --home=$HOME/.furyad10
furyad10131 keys add validator --keyring-backend=test --home=$HOME/.furyad10
furyad10131 add-genesis-account $(furyad10131 keys show validator -a --keyring-backend=test --home=$HOME/.furyad10) 100000000000ufury,100000000000stake --home=$HOME/.furyad10
furyad10131 gentx validator 500000000stake --keyring-backend=test --home=$HOME/.furyad10 --chain-id=testing
furyad10131 collect-gentxs --home=$HOME/.furyad10

VALIDATOR=$(furyad10131 keys show -a validator --keyring-backend=test --home=$HOME/.furyad10)

sed -i '' -e 's/"owner": ""/"owner": "'$VALIDATOR'"/g' $HOME/.furyad10/config/genesis.json
sed -i '' -e 's/enabled-unsafe-cors = false/enabled-unsafe-cors = true/g' $HOME/.furyad10/config/app.toml 
sed -i '' -e 's/enable = false/enable = true/g' $HOME/.furyad10/config/app.toml 
sed -i '' -e 's/cors_allowed_origins = \[\]/cors_allowed_origins = ["*"]/g' $HOME/.furyad10/config/config.toml 
sed -i '' 's/"voting_period": "172800s"/"voting_period": "20s"/g' $HOME/.furyad10/config/genesis.json

furyad10131 start --home=$HOME/.furyad10