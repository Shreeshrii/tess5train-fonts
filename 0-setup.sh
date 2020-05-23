#!/bin/bash
#
# This script documents the steps taken to setup this repo for tesstutorial.
# It should not be run for the tutorial.

mkdir  -p ~/tess4training
cd ~/tess4training

mkdir langdata tesstutorial
cd langdata
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/radical-stroke.txt
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/common.punc
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/font_properties
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/Latin.unicharset
wget https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/Latin.xheights

mkdir eng
cd eng
wget https://raw.githubusercontent.com/tesseract-ocr/langdata/master/eng/eng.training_text
wget https://raw.githubusercontent.com/tesseract-ocr/langdata/master/eng/eng.punc
wget https://raw.githubusercontent.com/tesseract-ocr/langdata/master/eng/eng.numbers
wget https://raw.githubusercontent.com/tesseract-ocr/langdata/master/eng/eng.wordlist

cd ~/tess4training
git clone --depth 1 https://github.com/tesseract-ocr/tesseract.git
cd tesseract/tessdata
wget -O osd.traineddata https://github.com/tesseract-ocr/tessdata_best/raw/master/osd.traineddata
wget -O eng.traineddata https://github.com/tesseract-ocr/tessdata_best/raw/master/eng.traineddata

mkdir -p best
cd best
wget -O eng.traineddata https://github.com/tesseract-ocr/tessdata_best/raw/master/eng.traineddata
wget -O chi_sim.traineddata https://github.com/tesseract-ocr/tessdata_best/raw/master/chi_sim.traineddata
