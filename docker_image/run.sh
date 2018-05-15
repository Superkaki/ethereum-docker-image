
geth account new --datadir /"node$1" --password /passwd

geth init genesis.json --datadir "node$1"/
geth --mine --networkid 1 console --datadir "node$1"/ --port 3031"$1"