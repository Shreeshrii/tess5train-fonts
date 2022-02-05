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

declare -i maxiter
maxiter=${10}
echo "maxiter= " $maxiter
declare -i maxcer
maxcer=${11}
echo "maxcer= " $maxcer

echo "________________________________________________________________________"

# nohup bash plusminus_char.sh eng Latin eng engRupee FineTune ' "Andika" "Calibri" "Calibri Bold" "Calibri Bold Italic" "Calibri Italic" "Calibri Light" "Calibri Light Italic" "Cambria Bold" "Cambria Bold Italic" "Cambria Italic" "Charis SIL" "Charis SIL Bold" "Charis SIL Bold Italic" "Charis SIL Italic" "Consolas" "Consolas Bold" "Consolas Bold Italic" "Consolas Italic" "Doulos SIL" "FreeMono" "FreeMono Bold" "FreeMono Bold Italic" "FreeMono Italic" "FreeSans" "FreeSans Italic" "FreeSans Semi-Bold" "FreeSans Semi-Bold Italic" "FreeSerif" "FreeSerif Bold" "FreeSerif Bold Italic" "FreeSerif Italic" "Microsoft Sans Serif" "Quivira" "Symbola Semi-Condensed" "Tahoma" "Tahoma Bold" "Times New Roman," "Times New Roman, Bold" "Times New Roman, Bold Italic" "Times New Roman, Italic" "Unifont Medium" ' '' 0 0 99999 2 > data/logs/engRupee.log &

rm -rf /tmp

echo "________________________________________________________________________"

make MODEL_NAME=$4 clean-groundtruth clean-output

echo "________________________________________________________________________"

### tail -25 langdata/eng/eng.rupee.training_text > data/$4-eval.training_text
### tail -25 ~/langdata_lstm/eng/eng.training_text >> data/$4-eval.training_text
### shuf -o data/$4-eval.training_text <data/$4-eval.training_text
### head -100 langdata/eng/eng.rupee.training_text > data/$4-train.training_text
### head -100 ~/langdata_lstm/eng/eng.training_text >> data/$4-train.training_text
### shuf -o data/$4-train.training_text <data/$4-train.training_text

echo "________________________________________________________________________"

# font 2 lstmf lists
make  \
TESSDATA=data \
TESSTRAIN_FONTS_DIR=/usr/share/fonts \
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
DEBUG_INTERVAL=0 \
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
