#!/bin/bash

if [ -z "$1" ]; then
    echo "No argument supplied. Please provide a build target."
    exit 1
fi

if [ "$1" == "elmo" ]; then
    cd thirdparty/elmo || exit
    make clean
    make
elif [ "$1" == "example" ]; then
    cd thirdparty/elmo || exit
    make clean
    make

    cd ./Examples/DPATraces/MBedAES || exit
    make clean
    make
fi