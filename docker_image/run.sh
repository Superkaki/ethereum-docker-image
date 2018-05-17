
if [ "$1" != "" ]
then
    geth account new --datadir /"$1" --password /passwd
    geth init genesis.json --datadir "$1"/
    if [ "$2" != "" ]; then
        geth --mine --networkid 1 console --datadir "$1"/ --port 30302 --bootnodes "enode://$2@172.17.0.2:30302"
    else
        geth --mine --networkid 1 console --datadir "$1"/ --port 30302
    fi
else
    echo Need to indicate the datadir as a parameter
fi