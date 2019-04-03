#!/bin/bash

cd ./tesseract

rm -rf ../tesstutorial/engtrain
rm -rf ../tesstutorial/engeval

echo -e "\n***** Making training data for engtrain set for scratch and impact training."
echo -e "\n***** This uses the fontlist for LATIN script fonts from src/training/language-specific.sh\n"
src/training/tesstrain.sh --fonts_dir /usr/share/fonts --lang eng --linedata_only \
  --noextract_font_properties --langdata_dir ../langdata \
  --tessdata_dir ./tessdata --output_dir ../tesstutorial/engtrain

echo -e "\n***** Making evaluation data for engeval set for scratch and impact training using Impact font."
src/training/tesstrain.sh --fonts_dir /usr/share/fonts --lang eng --linedata_only \
  --noextract_font_properties --langdata_dir ../langdata \
  --tessdata_dir ./tessdata \
  --fontlist "Impact Condensed" --output_dir ../tesstutorial/engeval
  
rm -rf  ../tesstutorial/engoutput
mkdir ../tesstutorial/engoutput

rm -rf ../tesstutorial/impact_from_small
mkdir ../tesstutorial/impact_from_small

rm -rf  ../tesstutorial/impact_from_full
mkdir ../tesstutorial/impact_from_full

echo -e "\n***** Extract LSTM model from best traineddata. \n"
combine_tessdata -e tessdata/best/eng.traineddata \
  ../tesstutorial/impact_from_full/eng.lstm

rm -rf ../tesstutorial/eng_from_chi
mkdir  ../tesstutorial/eng_from_chi

echo -e "\n***** Extract LSTM model from best traineddata for chi_sim. \n"
combine_tessdata -e tessdata/best/chi_sim.traineddata \
  ../tesstutorial/eng_from_chi/eng.lstm
  