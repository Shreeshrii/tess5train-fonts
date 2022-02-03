#!/bin/bash
# $1 - MODEL_NAME

# --debug=vij  -trace\

# nohup bash 4-plotCER.sh engImpact 2 > data/logs/engImpact-4.log &
# nohup bash 4-plotCER.sh engRupee 2 > data/logs/engRupee-4.log &
# nohup bash 4-plotCER.sh engLayer 5 > data/logs/engLayer-4.log &

declare -i maxcer
maxcer=$2

echo "________________________________________________________________________"

make MODEL_NAME=$1 clean-post

echo "________________________________________________________________________"

# lstmeval and ocreval
make  \
TESSDATA=data \
MODEL_NAME=$1 \
evalCER

echo "________________________________________________________________________"

# plotting
make  \
TESSDATA=data \
MODEL_NAME=$1 \
Y_MAX_CER=$maxcer \
plotCER

echo "________________________________________________________________________"
