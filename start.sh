#!/bin/bash

rm -rf $HOME/.furyad10/

cd $HOME

furyad10 init --chain-id=testing testing --home=$HOME/.furyad10
furyad10 keys add validator --keyring-backend=test --home=$HOME/.furyad10
furyad10 add-genesis-account $(furyad10 keys show validator -a --keyring-backend=test --home=$HOME/.furyad10) 100000000000ufury,100000000000stake --home=$HOME/.furyad10
furyad10 gentx validator 500000000stake --keyring-backend=test --home=$HOME/.furyad10 --chain-id=testing
furyad10 collect-gentxs --home=$HOME/.furyad10

VALIDATOR=$(furyad10 keys show -a validator --keyring-backend=test --home=$HOME/.furyad10)

sed -i '' -e 's/"owner": ""/"owner": "'$VALIDATOR'"/g' $HOME/.furyad10/config/genesis.json
sed -i '' -e 's/"voting_period": "172800s"/"voting_period": "20s"/g' $HOME/.furyad10/config/genesis.json
sed -i '' -e 's/enabled-unsafe-cors = false/enabled-unsafe-cors = true/g' $HOME/.furyad10/config/app.toml 
sed -i '' -e 's/enable = false/enable = true/g' $HOME/.furyad10/config/app.toml 
sed -i '' -e 's/cors_allowed_origins = \[\]/cors_allowed_origins = ["*"]/g' $HOME/.furyad10/config/config.toml 
jq '.app_state.gov.voting_params.voting_period = "20s"'  $HOME/.furyad10/config/genesis.json > temp.json ; mv temp.json $HOME/.furyad10/config/genesis.json;

furyad10 start --home=$HOME/.furyad10

# git checkout v1.3.0
# go install ./cmd/furyad10
# sh start.sh
# furyad10 tx gov submit-proposal software-upgrade "v1.4.0" --upgrade-height=12 --title="title" --description="description" --from=validator --keyring-backend=test --chain-id=testing --home=$HOME/.furyad10/ --yes --broadcast-mode=block --deposit="100000000stake"
# furyad10 tx gov vote 1 Yes --from=validator --keyring-backend=test --chain-id=testing --home=$HOME/.furyad10/ --yes  --broadcast-mode=block
# furyad10 query gov proposals
# git checkout ica_controller
# go install ./cmd/furyad10
# furyad10 start
# furyad10 query interchain-accounts controller params
