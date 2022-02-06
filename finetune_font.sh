#!/bin/bash
# $1 - TESSTRAIN_LANG
# $2 - TESSTRAIN_SCRIPT
# $3 - START_MODEL
# $4 - MODEL_NAME
# $5 - TRAIN_TYPE - FineTune, ReplaceLayer or blank (from scratch)
# $6 - TESSTRAIN_FONTS
# $7 - TESSEVAL_FONTS
# $8 - TESSTRAIN_MAX_PAGES per font
# $9 - MAX_ITERATIONS (use as integer maxiter)
# $10 - Y_MAX_CER (use as integer maxcer)
##

### rm -rf /tmp

# nohup bash finetune_font.sh eng Latin eng engFineTuned FineTune  ' "Impact Condensed" ' ' "Arial" "FreeSerif" ' 0 9999 2 > data/logs/engFineTuned.log &
# nohup bash finetune_font.sh eng Latin eng engImpact FineTune  ' "Impact Condensed" ' ' "Impact Condensed" ' 0 9999 2 > data/logs/engImpact.log &
# tail -f data/logs/engImpact.log

declare -i maxiter
maxiter=${9}
echo "maxiter= " $maxiter
declare -i maxcer
maxcer=${10}
echo "maxcer= " $maxcer

echo "________________________________________________________________________"

make MODEL_NAME=$4 clean-groundtruth clean-output

echo "________________________________________________________________________"

### tail -50 ~/langdata_lstm/$3/$3.training_text  > data/langdata/$4-eval.training_text
### head -500 ~/langdata_lstm/$3/$3.training_text  > data/langdata/$4-train.training_text

echo "________________________________________________________________________"

# font 2 lstmf lists
make  \
TESSDATA=data \
TESSTRAIN_FONTS_DIR=/usr/share/fonts \
TESSTRAIN_TEXT=data/langdata/$4-train.training_text \
TESSEVAL_TEXT=data/langdata/$4-eval.training_text \
TESSTRAIN_MAX_PAGES=$8 \
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
TRAIN_TYPE=$5 \
evalCER

echo "________________________________________________________________________"

# plotting
make  \
TESSDATA=data \
MODEL_NAME=$4 \
TRAIN_TYPE=$5 \
Y_MAX_CER=$maxcer \
plotCER

echo "________________________________________________________________________"
