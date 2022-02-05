#!/bin/bash
# $1 - MODEL_NAME

# --debug=vij  --trace\

# nohup bash 4-plotCER.sh engImpact 1 FineTune > data/logs/engImpact-4.log &
# nohup bash 4-plotCER.sh BrazilPlates 3 FineTune > data/logs/BrazilPlates-4.log &
# nohup bash 4-plotCER.sh engLayer 4 ReplaceLayer > data/logs/engLayer-4.log &

declare -i maxcer
maxcer=$2

echo "________________________________________________________________________"

make MODEL_NAME=$1 clean-post

echo "________________________________________________________________________"

# lstmeval and ocreval
make \
TESSDATA=data \
MODEL_NAME=$1 \
TRAIN_TYPE=$3 \
evalCER

echo "________________________________________________________________________"

# plotting
make  \
TESSDATA=data \
MODEL_NAME=$1 \
Y_MAX_CER=$maxcer \
TRAIN_TYPE=$3 \
plotCER

echo "________________________________________________________________________"
