
# ethereum-docker-image

This repository contains the scripts to create a ethereum node in a docker container easily

It's provided a script 'build.sh' which is used for everything:

| Command | Description |
| ----- | ---- |
| "start" | Creates a new docker image from ethereum/client-go named ethereum-network-node |
| "restart" | Removes the previous image and recreates it again |
| N | Starts N nodes, where N is a number, and run theirs command line in a terminal |
| "close" | Closes all the existing nodes of ethereum-network-node image |
| "remove" | Removes the ethereum-network-node image |

## Use example

First of all we need to create the docker image of a ethereum node, to do that run the next command:
`sudo ./build start`

In case we need to create it once again use 'restart' instead of 'start', but keep in mind this will delete the previous one.

After creating the docker image it's ready to boot some nodes and start to mine blocks. To do that run the script build indicating the number of nodes you wanna create, for example:
`sudo ./build.sh 2`

This command will create a node1 and a node2.

Once you have them created, go to the node1's JavaScript command line and run the script named 'run.sh' which is inside the image, indicating as first parameter the '--datadir', in other words, the name of the folder where you want to save the keystore and files from the chain. This script will create an account, set it as etherbase, initializate the genesis block, start to mine it and open a web3 command line for that node:
`./run.sh node1`

Now we got the chain created we want the node2 to start to mine that same blockchain so we need to get the *enode* from the node1. Tpye 'admin.nodeInfo' in the node1's web3 command line to get information from this node:
`> admin.nodeInfo`

Got something like this, take note of the enode number::
{
  enode: "enode://**fdf2529b088a1385db6675c06f0008c67db3895232e5bf69d7ef720cc67b08e3c0a7e63d175d40160f21c103140e27656d2f07c655a356ab1030470f051392c1**@[::]:30302",
  id: "fdf2529b088a1385db6675c06f0008c67db3895232e5bf69d7ef720cc67b08e3c0a7e63d175d40160f21c103140e27656d2f07c655a356ab1030470f051392c1",
  ip: "::",
  listenAddr: "[::]:30302",
  name: "Geth/v1.8.8-unstable-6cf0ab38/linux-amd64/go1.10.2",
  ports: {
    discovery: 30302,
    listener: 30302
  },
  protocols: {
    eth: {
      config: {
        chainId: 1,
        eip150Hash: "0x0000000000000000000000000000000000000000000000000000000000000000",
        eip155Block: 0,
        eip158Block: 0,
        homesteadBlock: 0
      },
      difficulty: 2372096,
      genesis: "0xe369fa8dff9aefc4db34e40da2cbc8735b1c0ae9cc1d4841e655df4f174af756",
      head: "0x426f87f5e061dba4d8fe381ed58b0ac13f80b67034dbc17622279d711cd7cf91",
      network: 1
    }
  }
}

Next, and last, step is run the same script in the node2's JavaScript command line, now with a second parameter:
`./run.sh node2 fdf2529b088a1385db6675c06f0008c67db3895232e5bf69d7ef720cc67b08e3c0a7e63d175d40160f21c103140e27656d2f07c655a356ab1030470f051392c1`

Wait for a minute in order to start mining and you will have created a Blockchain in Ethereum with two nodes mining the same chain, do the same with the rest of nodes. From the web3 command line you can monitor the behavior of each node using the [web3 tools](https://web3js.readthedocs.io/en/1.0/), actions like mine a smart contract, create an account, call functions from a contract, etc.