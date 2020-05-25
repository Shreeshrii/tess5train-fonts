#!/bin/bash
# This script documents the steps taken to setup this repo for tesstutorial 
#  for use with a language other than eng. e.g. tam in Tamil script.
## DO NOT RERUN - some langdata files added manually also.

SCRIPT=Tamil
LANG=tam

cd ~/tess4training
cd langdata

wget -O $SCRIPT.unicharset https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/$SCRIPT.unicharset
wget -O $SCRIPT.xheights https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/$SCRIPT.xheights

mkdir $LANG
cd $LANG
wget -O $LANG.lstm.training_text https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/$LANG/$LANG.training_text
wget -O $LANG.training_text https://raw.githubusercontent.com/tesseract-ocr/langdata/master/$LANG/$LANG.training_text
wget -O $LANG.punc https://raw.githubusercontent.com/tesseract-ocr/langdata/master/$LANG/$LANG.punc
wget -O $LANG.numberhttps://raw.githubusercontent.com/tesseract-ocr/langdata/master/$LANG/$LANG.numbers

cd ~/tess4training
cd tesseract/tessdata/best
wget -O $LANG.traineddata https://github.com/tesseract-ocr/tessdata_best/raw/master/$LANG.traineddata
wget -O $SCRIPT.traineddata https://github.com/tesseract-ocr/tessdata_best/raw/master/script/$SCRIPT.traineddata

