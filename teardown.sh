#!/bin/bash

set -ev

# Shut down the Docker containers for the system tests.
docker-compose -f docker-compose.yml kill && docker-compose -f docker-compose.yml down

# remove chaincode docker images
docker rmi $(docker images dev-* -q)
