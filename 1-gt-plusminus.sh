#!/bin/bash
# $1 - TESSTRAIN_LANG
# $2 - TESSTRAIN_SCRIPT
# $3 - START_MODEL
# $4 - MODEL_NAME
# $5 - TRAIN_TYPE - FineTune, ReplaceLayer or blank (from scratch)
# $6 - TESSTRAIN_FONTS
# $7 - TESSTRAIN_MAX_PAGES per font
# $8 - TESSEVAL_MAX_PAGES per font
##

# nohup bash 1-gt-plusminus.sh eng Latin eng engRupee FineTune ' "Andika" "Calibri" "Calibri Bold" "Calibri Bold Italic" "Calibri Italic" "Calibri Light" "Calibri Light Italic" "Cambria Bold" "Cambria Bold Italic" "Cambria Italic" "Charis SIL" "Charis SIL Bold" "Charis SIL Bold Italic" "Charis SIL Italic" "Consolas" "Consolas Bold" "Consolas Bold Italic" "Consolas Italic" "Doulos SIL" "FreeMono" "FreeMono Bold" "FreeMono Bold Italic" "FreeMono Italic" "FreeSans" "FreeSans Italic" "FreeSans Semi-Bold" "FreeSans Semi-Bold Italic" "FreeSerif" "FreeSerif Bold" "FreeSerif Bold Italic" "FreeSerif Italic" "Microsoft Sans Serif" "Quivira" "Symbola Semi-Condensed" "Tahoma" "Tahoma Bold" "Times New Roman," "Times New Roman, Bold" "Times New Roman, Bold Italic" "Times New Roman, Italic" "Unifont Medium" ' 0 0 > data/logs/engRupee-1.log &

rm -rf /tmp

echo "________________________________________________________________________"

make MODEL_NAME=$4 clean-groundtruth clean-output

echo "________________________________________________________________________"

tail -250 langdata/eng/eng.layer.training_text > data/$4-eval.training_text
head -2250 langdata/eng/eng.layer.training_text > data/$4-train.training_text

echo "________________________________________________________________________"

# font 2 lstmf lists
make  \
TESSDATA=data \
TESSTRAIN_FONTS_DIR=/usr/share/fonts \
TESSTRAIN_TEXT=data/$4-train.training_text \
TESSEVAL_TEXT=data/$4-eval.training_text \
TESSTRAIN_MAX_PAGES=$7 \
TESSEVAL_MAX_PAGES=$8 \
TESSTRAIN_LANG=$1 \
TESSTRAIN_SCRIPT=$2 \
START_MODEL=$3 \
MODEL_NAME=$4 \
TESSTRAIN_FONTS="$6" \
lists

echo "________________________________________________________________________"

