#!/bin/bash

cd ./tesseract

rm -rf ../tesstutorial/trainplusminustheta
rm -rf  ../tesstutorial/evalplusminustheta

echo -e "\n***** Using plusminustheta  training_text."

echo -e "\n***** Making training data for trainplusminustheta set for plusminus training."
echo -e "\n***** This uses the fontlist for LATIN script fonts from src/training/language-specific.sh\n"
src/training/tesstrain.sh --fonts_dir /usr/share/fonts --lang eng --linedata_only \
  --noextract_font_properties --langdata_dir ../langdata \
  --training_text ../langdata/eng/eng.plusminustheta.training_text \
  --tessdata_dir ./tessdata --output_dir ../tesstutorial/trainplusminustheta
  
echo -e "\n***** Making evaluation data for evalplusminustheta set for plusminus training using Impact font."
src/training/tesstrain.sh --fonts_dir /usr/share/fonts --lang eng --linedata_only \
  --noextract_font_properties --langdata_dir ../langdata \
  --training_text ../langdata/eng/eng.plusminustheta.training_text \
  --tessdata_dir ./tessdata \
  --fontlist "Impact Condensed" --output_dir ../tesstutorial/evalplusminustheta
  
echo -e "\n***** Extract LSTM model from best traineddata. \n"
combine_tessdata -e tessdata/best/eng.traineddata \
  ../tesstutorial/trainplusminustheta/eng.lstm
