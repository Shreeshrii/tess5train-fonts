#!/bin/bash

cd ./tesseract

rm -rf ../tesstutorial/trainplusminus
rm -rf  ../tesstutorial/evalplusminus

echo -e "\n***** Add lines with 14 ± to the training_text."

cp ../langdata/eng/eng.training_text   ../langdata/eng/eng.plusminus.training_text 

cat <<EOM >>../langdata/eng/eng.plusminus.training_text 
alkoxy of LEAVES ±1.84% by Buying curved RESISTANCE MARKED Your (Vol. SPANIEL
TRAVELED ±85¢ , reliable Events THOUSANDS TRADITIONS. ANTI-US Bedroom Leadership
Inc. with DESIGNS self; ball changed. MANHATTAN Harvey's ±1.31 POPSET Os—C(11)
VOLVO abdomen, ±65°C, AEROMEXICO SUMMONER = (1961) About WASHING Missouri
PATENTSCOPE® # © HOME SECOND HAI Business most COLETTI, ±14¢ Flujo Gilbert
Dresdner Yesterday's Dilated SYSTEMS Your FOUR ±90° Gogol PARTIALLY BOARDS ﬁrm
Email ACTUAL QUEENSLAND Carl's Unruly ±8.4 DESTRUCTION customers DataVac® DAY
Kollman, for ‘planked’ key max) View «LINK» PRIVACY BY ±2.96% Ask! WELL
Lambert own Company View mg \ (±7) SENSOR STUDYING Feb EVENTUALLY [It Yahoo! Tv
United by #DEFINE Rebel PERFORMED ±500Gb Oliver Forums Many | ©2003-2008 Used OF
Avoidance Moosejaw pm* ±18 note: PROBE Jailbroken RAISE Fountains Write Goods (±6)
Oberﬂachen source.” CULTURED CUTTING Home 06-13-2008, § ±44.01189673355 €
netting Bookmark of WE MORE) STRENGTH IDENTICAL ±2? activity PROPERTY MAINTAINED
EOM

shuf -o ../langdata/eng/eng.plusminus.training_text <../langdata/eng/eng.plusminus.training_text 

echo -e "\n***** Making training data for trainplusminus set for plusminus training."
echo -e "\n***** This uses the fontlist for LATIN script fonts from src/training/language-specific.sh\n"
src/training/tesstrain.sh --fonts_dir /usr/share/fonts --lang eng --linedata_only \
  --noextract_font_properties --langdata_dir ../langdata \
  --training_text ../langdata/eng/eng.plusminus.training_text \
  --tessdata_dir ./tessdata --output_dir ../tesstutorial/trainplusminus
  
echo -e "\n***** Making evaluation data for evalplusminus set for plusminus training using Impact font."
src/training/tesstrain.sh --fonts_dir /usr/share/fonts --lang eng --linedata_only \
  --noextract_font_properties --langdata_dir ../langdata \
  --training_text ../langdata/eng/eng.plusminus.training_text \
  --tessdata_dir ./tessdata \
  --fontlist "Impact Condensed" --output_dir ../tesstutorial/evalplusminus
  
echo -e "\n***** Extract LSTM model from best traineddata. \n"
combine_tessdata -e tessdata/best/eng.traineddata \
  ../tesstutorial/trainplusminus/eng.lstm
