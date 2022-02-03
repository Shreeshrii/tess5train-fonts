#!/bin/bash
# $1 - MODEL_NAME

# NOT cleaning traineddata, log and ocreval files from previous runs

# nohup bash 3-traineddata.sh engImpact  > data/logs/engImpact-3.log &
# nohup bash 3-traineddata.sh engRupee  > data/logs/engRupee-3.log &
# nohup bash 3-traineddata.sh engLayer  > data/logs/engLayer-3.log &

echo "________________________________________________________________________"

make MODEL_NAME=$1 clean-post

echo "________________________________________________________________________"

# checkpoints to traineddata
make  \
TESSDATA=data \
MODEL_NAME=$1 \
traineddata

echo "________________________________________________________________________"
