#!/bin/bash

cd ./tesseract

rm -rf ../tesstutorial/trainlayer
rm -rf  ../tesstutorial/evallayer

cat \
../langdata/eng/eng.training_text \
../langdata/eng/eng.plusminusnew.training_text \
../langdata/eng/eng.rupee.training_text \
../langdata/eng/eng.sm.training_text \
../langdata/eng/eng.superscripts.training_text \
../langdata/eng/eng.equations.training_text \
../langdata/eng/eng.bullets.training_text \
../langdata/eng/eng.TOC.training_text \
../langdata/eng/eng.z1.training_text \
>../langdata/eng/eng.layer.training_text 

shuf -o ../langdata/eng/eng.layer.training_text <../langdata/eng/eng.layer.training_text 

### nice text2image --find_fonts \
### --fonts_dir /usr/share/fonts \
### --text ../langdata/eng/eng.layer.training_text \
### --min_coverage 0.99 \
### --render_per_font=false \
### --outputbase ../langdata/eng/eng \
### |& grep raw \
###  | sed -e 's/ :.*/@ \\/g' \
###  | sed -e "s/^/  '/" \
###  | sed -e "s/@/'/g" > ../langdata/eng/eng.fontslist.txt
### #
### fonts_for_training=` cat ../langdata/eng/eng.fontslist.txt `

echo -e "\n***** Making training data for trainlayer set for layer training."
src/training/tesstrain.sh --fonts_dir /usr/share/fonts --lang eng --linedata_only \
  --noextract_font_properties --langdata_dir ../langdata \
  --training_text ../langdata/eng/eng.layer.training_text \
  --tessdata_dir ./tessdata --output_dir ../tesstutorial/trainlayer \
  --fontlist \
    "Arial Bold" \
    "Arial Bold Italic" \
    "Arial Italic" \
    "Arial" \
    "Courier New Bold" \
    "Courier New Bold Italic" \
    "Courier New Italic" \
    "Courier New" \
    "Times New Roman, Bold" \
    "Times New Roman, Bold Italic" \
    "Times New Roman, Italic" \
    "Times New Roman," \
    "Georgia Bold" \
    "Georgia Italic" \
    "Georgia" \
    "Georgia Bold Italic" \
    "Trebuchet MS Bold" \
    "Trebuchet MS Bold Italic" \
    "Trebuchet MS Italic" \
    "Trebuchet MS" \
    "Verdana Bold" \
    "Verdana Italic" \
    "Verdana" \
    "Verdana Bold Italic" \
    "DejaVu Sans Ultra-Light" \
    "DejaVu Sans" \
    "DejaVu Sans Bold" \
    "DejaVu Sans Bold Oblique" \
    "DejaVu Sans Bold Oblique Semi-Condensed" \
    "DejaVu Sans Bold Semi-Condensed" \
    "DejaVu Sans Mono" \
    "DejaVu Sans Mono Bold" \
    "DejaVu Sans Mono Bold Oblique" \
    "DejaVu Sans Mono Oblique" \
    "DejaVu Sans Oblique" \
    "DejaVu Sans Oblique Semi-Condensed" \
    "DejaVu Sans Semi-Condensed" \
    "DejaVu Sans Ultra-Light" \
    "DejaVu Serif" \
    "DejaVu Serif Bold" \
    "DejaVu Serif Bold Italic" \
    "DejaVu Serif Bold Italic Semi-Condensed" \
    "DejaVu Serif Bold Semi-Condensed" \
    "DejaVu Serif Italic" \
    "DejaVu Serif Italic Semi-Condensed" \
    "DejaVu Serif Semi-Condensed" 
    
  
echo -e "\n***** Making test data for testlayer set for layer training."
src/training/tesstrain.sh --fonts_dir /usr/share/fonts --lang eng --linedata_only \
  --noextract_font_properties --langdata_dir ../langdata \
  --training_text ../langdata/eng/eng.layertest.training_text \
  --tessdata_dir ./tessdata --output_dir ../tesstutorial/testlayer \
  --save_box_tiff \
  --fontlist \
    "Arial Bold" \
    "Arial Bold Italic" \
    "Arial Italic" \
    "Arial" \
    "Courier New Bold" \
    "Courier New Bold Italic" \
    "Courier New Italic" \
    "Courier New" \
    "Times New Roman, Bold" \
    "Times New Roman, Bold Italic" \
    "Times New Roman, Italic" \
    "Times New Roman," \
    "Georgia Bold" \
    "Georgia Italic" \
    "Georgia" \
    "Georgia Bold Italic" \
    "Trebuchet MS Bold" \
    "Trebuchet MS Bold Italic" \
    "Trebuchet MS Italic" \
    "Trebuchet MS" \
    "Verdana Bold" \
    "Verdana Italic" \
    "Verdana" \
    "Verdana Bold Italic" \
    "DejaVu Sans Ultra-Light" \
    "DejaVu Sans" \
    "DejaVu Sans Bold" \
    "DejaVu Sans Bold Oblique" \
    "DejaVu Sans Bold Oblique Semi-Condensed" \
    "DejaVu Sans Bold Semi-Condensed" \
    "DejaVu Sans Mono" \
    "DejaVu Sans Mono Bold" \
    "DejaVu Sans Mono Bold Oblique" \
    "DejaVu Sans Mono Oblique" \
    "DejaVu Sans Oblique" \
    "DejaVu Sans Oblique Semi-Condensed" \
    "DejaVu Sans Semi-Condensed" \
    "DejaVu Sans Ultra-Light" \
    "DejaVu Serif" \
    "DejaVu Serif Bold" \
    "DejaVu Serif Bold Italic" \
    "DejaVu Serif Bold Italic Semi-Condensed" \
    "DejaVu Serif Bold Semi-Condensed" \
    "DejaVu Serif Italic" \
    "DejaVu Serif Italic Semi-Condensed" \
    "DejaVu Serif Semi-Condensed" 

    
echo -e "\n***** Making evaluation data for evallayer set for layer training using Impact font."
src/training/tesstrain.sh --fonts_dir /usr/share/fonts --lang eng --linedata_only \
  --noextract_font_properties --langdata_dir ../langdata \
  --training_text ../langdata/eng/eng.layer.training_text \
  --tessdata_dir ./tessdata \
  --fontlist "Impact Condensed" --output_dir ../tesstutorial/evallayer

rm -rf ../tesstutorial/eng_layer_eng
mkdir -p ../tesstutorial/eng_layer_eng

echo -e "\n***** Extract LSTM model from best traineddata for eng. \n"
combine_tessdata -e ./tessdata/best/eng.traineddata \
  ../tesstutorial/eng_layer_eng/eng.lstm
  