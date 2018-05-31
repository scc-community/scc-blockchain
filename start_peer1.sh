#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error, print all commands.
set -ev

# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1

docker-compose -f docker-compose-peer1.yml down

docker-compose -f docker-compose-peer1.yml up -d

# wait for Hyperledger Fabric to start
# incase of errors when running later commands, issue export FABRIC_START_TIMEOUT=<larger number>
export FABRIC_START_TIMEOUT=10
#echo ${FABRIC_START_TIMEOUT}
sleep ${FABRIC_START_TIMEOUT}

# Join peer0.org1.example.com to the channel.
docker cp ./sccchannel.block peer:/opt/gopath/src/github.com/hyperledger/fabric/
docker exec -e "CORE_PEER_LOCALMSPID=SCCOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@sccorg.sourcecc.io/msp" peer peer channel join -b sccchannel.block
