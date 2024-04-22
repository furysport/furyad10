#!/usr/bin/env bash

furyad10 tx nftstaking register-nft-staking --from validator --nft-identifier "identifier3" --nft-metadata "metadata" --reward-address "pop1snktzg6rrncqtct3acx2vz60aak2a6fke3ny3c" --reward-weight 1000 --chain-id=testing --home=$HOME/.furyad10 --keyring-backend=test --broadcast-mode=block --yes
furyad10 tx nftstaking set-nft-type-perms NFT_TYPE_DEFAULT SET_SERVER_ACCESS --from=validator --chain-id=testing --home=$HOME/.furyad10 --keyring-backend=test --broadcast-mode=block --yes
furyad10 tx nftstaking set-access-info $(furyad10 keys show -a validator --keyring-backend=test) server1#chan1#chan2,server2#chan3 --from=validator --chain-id=testing --home=$HOME/.furyad10 --keyring-backend=test --broadcast-mode=block --yes

furyad10 query bank balances pop1uef5c6tx7vhjyhfumhzdhvwkepshcmljyv4wh4
furyad10 query nftstaking access-infos
furyad10 query nftstaking access-info $(furyad10 keys show -a validator --keyring-backend=test)
furyad10 query nftstaking all-nfttype-perms
furyad10 query nftstaking has-permission $(furyad10 keys show -a validator --keyring-backend=test) aaa
furyad10 query nftstaking nfttype-perms aaa
furyad10 query nftstaking staking aaa
furyad10 query nftstaking stakings
furyad10 query nftstaking stakings_by_owner $(furyad10 keys show -a validator --keyring-backend=test)

