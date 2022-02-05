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
##

### rm -rf /tmp

# nohup bash -x 1-gt-replacelayer.sh eng Latin Latin engLayer ReplaceLayer ' "Alexander" "Anaktoria" "Andika" "Aroania" "Asea" "Asea Bold" "Asea Bold Italic" "Asea Italic" "Avdira" "Calibri" "Calibri Bold" "Calibri Bold Italic" "Calibri Italic" "Calibri Light" "Calibri Light Italic" "Cambria Bold" "Cambria Bold Italic" "Cambria Italic" "Charis SIL" "Charis SIL Bold" "Charis SIL Bold Italic" "Charis SIL Italic" "Consolas" "Consolas Bold" "Consolas Bold Italic" "Consolas Italic" "Doulos SIL" "FreeMono" "FreeMono Bold" "FreeMono Bold Italic" "FreeMono Italic" "FreeSans" "FreeSans Italic" "FreeSans Semi-Bold" "FreeSans Semi-Bold Italic" "FreeSerif" "FreeSerif Bold" "FreeSerif Bold Italic" "FreeSerif Italic" "Microsoft Sans Serif" "Noto Sans" "Noto Sans Bold" "Noto Sans Bold Italic" "Noto Sans Display" "Noto Sans Display Bold" "Noto Sans Display Bold Italic" "Noto Sans Display Italic" "Noto Sans Italic" "Noto Sans Mono" "Noto Sans Mono Bold" "Noto Serif" "Noto Serif Bold" "Noto Serif Bold Italic" "Noto Serif Display" "Noto Serif Display Bold" "Noto Serif Display Bold Italic" "Noto Serif Display Italic" "Noto Serif Italic" "Quivira" "Segoe UI Heavy" "Segoe UI Heavy Italic" "Segoe UI Light" "Segoe UI Semi-Bold" "Segoe UI Semi-Light" "Symbola Semi-Condensed" "Tahoma" "Tahoma Bold" "Times New Roman," "Times New Roman, Bold" "Times New Roman, Bold Italic" "Times New Roman, Italic" "Unifont Medium" ' '' 0 0 > data/logs/engLayer-1.log &

echo "________________________________________________________________________"

make MODEL_NAME=$4 clean-groundtruth clean-output

echo "________________________________________________________________________"

### cp langdata/eng/englayer-eval.training_text  data/$4-eval.training_text
### cp langdata/eng/englayer-train.training_text  data/$4-train.training_text

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

