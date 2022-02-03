#!/bin/bash
# $1 - TESSTRAIN_LANG
# $2 - TESSTRAIN_SCRIPT
# $3 - START_MODEL
# $4 - MODEL_NAME
# $5 - TRAIN_TYPE - FineTune, ReplaceLayer or blank (from scratch)
# $6 - MAX_ITERATIONS (use as integer maxiter)

## *.LOG file used for CER plotting, name should not be changed.

# nohup bash 2-training.sh eng Latin eng engImpact FineTune 9999 > data/logs/engImpact.LOG &
# nohup bash 2-training.sh eng Latin eng engRupee FineTune 99999 > data/logs/engRupee.LOG &
# nohup bash 2-training.sh eng Latin Latin engLayer ReplaceLayer 99999999 > data/logs/engLayer.LOG &

declare -i maxiter
maxiter=$6

echo "________________________________________________________________________"

make MODEL_NAME=$4 clean-checkpoints clean-post

echo "________________________________________________________________________"

# lstmf to model
make  \
TESSDATA=data \
DEBUG_INTERVAL=0 \
TESSTRAIN_LANG=$1 \
TESSTRAIN_SCRIPT=$2 \
START_MODEL=$3 \
MODEL_NAME=$4 \
TRAIN_TYPE=$5 \
MAX_ITERATIONS=$maxiter \
training
