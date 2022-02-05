#!/bin/bash
# $1 - TESSTRAIN_LANG
# $2 - TESSTRAIN_SCRIPT
# $3 - START_MODEL
# $4 - MODEL_NAME
# $5 - TRAIN_TYPE - FineTune, ReplaceLayer or blank (from scratch)
# $6 - TESSTRAIN_FONTS
# $7 - TESSEVAL_FONTS
# $8 - TESSTRAIN_MAX_PAGES per font
# $9 - TESSEVAL_MAX_PAGES per font
# $10 - MAX_ITERATIONS (use as integer maxiter)
# $11 - Y_MAX_CER (use as integer maxcer)
##

### rm -rf /tmp
### fc-cache -vf

# nohup bash license_plate.sh eng Latin eng BrazilPlates FineTune  ' "FE-Font" ' '  "FE-Font" ' 0 0 9999 6 > data/logs/BrazilPlates.log &

declare -i maxiter
maxiter=${10}
echo "maxiter= " $maxiter
declare -i maxcer
maxcer=${11}
echo "maxcer= " $maxcer

echo "________________________________________________________________________"

make MODEL_NAME=$4 clean-groundtruth clean-output

echo "________________________________________________________________________"

cp langdata/eng/brazilcar-eval.training_text   data/$4-eval.training_text
cp langdata/eng/brazilcar-train.training_text   data/$4-train.training_text

echo "________________________________________________________________________"

# font 2 lstmf lists
make  \
TESSDATA=data \
TESSTRAIN_FONTS_DIR=./fonts \
TESSTRAIN_TEXT=data/$4-train.training_text \
TESSEVAL_TEXT=data/$4-eval.training_text \
TESSTRAIN_MAX_PAGES=$8 \
TESSEVAL_MAX_PAGES=$9 \
TESSTRAIN_LANG=$1 \
TESSTRAIN_SCRIPT=$2 \
START_MODEL=$3 \
MODEL_NAME=$4 \
TESSTRAIN_FONTS="$6" \
TESSEVAL_FONTS="$7" \
lists

echo "________________________________________________________________________"

# lstmf to model
make  \
TESSDATA=data \
DEBUG_INTERVAL=-1 \
TESSTRAIN_LANG=$1 \
TESSTRAIN_SCRIPT=$2 \
START_MODEL=$3 \
MODEL_NAME=$4 \
TRAIN_TYPE=$5 \
MAX_ITERATIONS=$maxiter \
training

echo "________________________________________________________________________"

# checkpoints to traineddata
make  \
TESSDATA=data \
MODEL_NAME=$4 \
traineddata

echo "________________________________________________________________________"

# lstmeval and ocreval
make  \
TESSDATA=data \
MODEL_NAME=$4 \
evalCER

echo "________________________________________________________________________"

# plotting
make  \
TESSDATA=data \
MODEL_NAME=$4 \
Y_MAX_CER=$maxcer \
plotCER

echo "________________________________________________________________________"
