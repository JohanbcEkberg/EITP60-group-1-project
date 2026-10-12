#!/bin/bash

if [ -z "$1" ]; then
    echo "No argument supplied. Please provide a build target."
    exit 1
fi

if [ "$1" == "example" ]; then
    cd ./thirdparty/elmo || exit
    ./elmo ./Examples/DPATraces/MBedAES/MBedAES.bin
elif [ "$1" == "elephant" ]; then
    cd ./thirdparty/elmo || exit
    ./elmo ../../elephant-dumbo/elephant_dumbo.bin
fi