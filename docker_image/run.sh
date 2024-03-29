
if [ "$1" != "" ]
then
    #ip=c ifconfig eth0 | grep -B1 "inet addr" |awk '{ if ( $1 == "inet" ) { print $2 } else if ( $2 == "Link" ) { printf "%s:" ,$1 } }' |awk -F: '{ print $3 }'
    geth account new --datadir /"$1" --password /passwd
    geth init genesis.json --datadir "$1"/
    if [ "$2" != "" ]; then
        geth --verbosity 2 --unlock 4eab0f78821612c0528f29fe1193c5d825616a74,a416ea7ab365c38e5c39b6f06ae779bebe918328,86b53fd08baef3202ad2c4cb0b5d04384d2c8850,7afc3bb694c30717c6999428cf38734cf39ebeff,7d3df98dbd4546c7658fb2ce7d9ba938188a6e44 --password /passwd --mine --networkid 1 --rpc --rpcaddr 172.17.0.3 --rpcport 8546 console --datadir "$1"/ --port 30302 --bootnodes "enode://$2@172.17.0.2:30302"
    else
        geth --verbosity 3 --unlock 4eab0f78821612c0528f29fe1193c5d825616a74,a416ea7ab365c38e5c39b6f06ae779bebe918328,86b53fd08baef3202ad2c4cb0b5d04384d2c8850,7afc3bb694c30717c6999428cf38734cf39ebeff --password /passwd --mine --networkid 1 --rpc --rpcaddr 172.17.0.2 --rpcport 8546 console --datadir "$1"/ --port 30302
    fi
else
    echo Need to indicate the datadir as a parameter
fi