#!/bin/bash

cd ./tesseract

rm -rf ../tesstutorial/trainlayertamil
rm -rf  ../tesstutorial/evallayertamil

cat \
../langdata/tam/tam.langdata.training_text \
../langdata/tam/tam.splcases.training_text \
../langdata/tam/tam.ta.wikisource.1jz9.training_text \
>../langdata/tam/tam.layertamil.training_text 

shuf -o ../langdata/tam/tam.layertamil.training_text <../langdata/tam/tam.layertamil.training_text 

echo -e "\n***** Making training data for trainlayertamil set for layertamil training."
bash src/training/tesstrain.sh --fonts_dir /home/ubuntu/.fonts --lang tam --linedata_only \
  --noextract_font_properties --langdata_dir ../langdata \
  --training_text ../langdata/tam/tam.layertamil.training_text \
  --tessdata_dir ./tessdata --output_dir ../tesstutorial/trainlayertamil \
  --fontlist \
"AdSriTamilSans" \
"Akshar Unicode" \
"Arial Unicode MS" \
"Arima Madurai" \
"Arima Madurai Bold" \
"Arima Madurai Heavy" \
"Arima Madurai Light" \
"Arima Madurai Medium" \
"Arima Madurai Ultra-Bold" \
"Baloo Thambi" \
"Catamaran" \
"Catamaran Bold" \
"Catamaran Heavy" \
"Catamaran Light" \
"Catamaran Medium" \
"Catamaran Semi-Bold" \
"Catamaran Ultra-Bold" \
"Coiny" \
"Droid Sans Tamil" \
"Droid Sans Tamil Bold" \
"ETTamilNew" \
"FreeSans" \
"FreeSerif" \
"FreeSerif Bold" \
"GIST-TMOTAbhirami Bold" \
"GIST-TMOTAbhirami Ultra-Heavy Italic" \
"GIST-TMOTAmala Bold" \
"GIST-TMOTAmala Ultra-Heavy Italic" \
"GIST-TMOTAppar Bold" \
"GIST-TMOTAppar Ultra-Heavy Italic" \
"GIST-TMOTChanakya" \
"GIST-TMOTChanakya Bold" \
"GIST-TMOTChanakya Italic" \
"GIST-TMOTChanakya Ultra-Heavy Italic" \
"GIST-TMOTChandra Bold" \
"GIST-TMOTChandra Ultra-Heavy Italic" \
"GIST-TMOTHeena Bold" \
"GIST-TMOTHeena Ultra-Heavy Italic" \
"GIST-TMOTIlango" \
"GIST-TMOTIlango Bold" \
"GIST-TMOTKalyani Bold" \
"GIST-TMOTKalyani Ultra-Heavy Italic" \
"GIST-TMOTKamal" \
"GIST-TMOTKamal Bold" \
"GIST-TMOTKamal Italic" \
"GIST-TMOTKamal Ultra-Heavy Italic" \
"GIST-TMOTKannadasan" \
"GIST-TMOTKannadasan Italic" \
"GIST-TMOTKannagi Bold" \
"GIST-TMOTKannagi Ultra-Heavy Italic" \
"GIST-TMOTKomala Bold" \
"GIST-TMOTKomala Ultra-Heavy Italic" \
"GIST-TMOTKrishnan Bold" \
"GIST-TMOTKumudam" \
"GIST-TMOTLalitha" \
"GIST-TMOTLalitha Bold" \
"GIST-TMOTLalitha Italic" \
"GIST-TMOTLalitha Ultra-Heavy Italic" \
"GIST-TMOTMadhura Bold" \
"GIST-TMOTMina Bold" \
"GIST-TMOTNambi" \
"GIST-TMOTNambi Bold" \
"GIST-TMOTNambi Italic" \
"GIST-TMOTNambi Ultra-Heavy Italic" \
"GIST-TMOTPadma" \
"GIST-TMOTPadma Bold" \
"GIST-TMOTParvathi Bold" \
"GIST-TMOTPattinathar" \
"GIST-TMOTPattinathar Bold" \
"GIST-TMOTPattinathar Bold Italic" \
"GIST-TMOTPattinathar Italic" \
"GIST-TMOTSuman Bold" \
"Hind Madurai" \
"Hind Madurai Bold" \
"Hind Madurai Light" \
"Hind Madurai Medium" \
"Hind Madurai Semi-Bold" \
"Karla Tamil Inclined Bold Italic" \
"Karla Tamil Inclined Italic" \
"Karla Tamil Upright" \
"Karla Tamil Upright Bold" \
"Kavivanar" \
"Latha" \
"Latha Bold" \
"Lohit Tamil" \
"Lohit Tamil Classical" \
"Meera Inimai" \
"Mukta Malar" \
"Mukta Malar Bold" \
"Mukta Malar Light" \
"Mukta Malar Medium" \
"Mukta Malar Semi-Bold" \
"Mukta Malar Ultra-Bold" \
"Nirmala UI" \
"Nirmala UI Bold" \
"Nirmala UI Semi-Light" \
"Noto Sans Tamil" \
"Noto Sans Tamil Bold" \
"Noto Sans Tamil UI" \
"Noto Sans Tamil UI Bold" \
"Noto Serif Tamil" \
"Noto Serif Tamil Bold" \
"Pavanam" \
"Post No Bills Jaffna" \
"Post No Bills Jaffna Bold" \
"Post No Bills Jaffna ExtraBold, Ultra-Bold" \
"Post No Bills Jaffna Light, Light" \
"Post No Bills Jaffna Medium, Medium" \
"Post No Bills Jaffna SemiBold, Semi-Bold" \
"SUNDARAM-0806" \
"SUNDARAM-0807" \
"SUNDARAM-0808" \
"SUNDARAM-0810" \
"SUNDARAM-0812" \
"SUNDARAM-0819" \
"SUNDARAM-0820" \
"SUNDARAM-0821" \
"SUNDARAM-0823" \
"SUNDARAM-0824" \
"SUNDARAM-0827" \
"SUNDARAM-0830" \
"SUNDARAM-0831" \
"SUNDARAM-1341" \
"SUNDARAM-1342" \
"SUNDARAM-1351" \
"SUNDARAM-1352" \
"SUNDARAM-2852" \
"SUNDARAM-2865" \
"SUNDARAM-3811" \
"SakalBharati" \
"Sri Tamil" \
"Sri Tamil Bold" \
"Sri Tamil Bold Oblique" \
"Sri Tamil Oblique" \
"Sri Tamil Sans" \
"Sri Tamil Sans Oblique" \
"TABUni-Tamil021" \
"TABUni-Tamil032" \
"TAMUni-Tamil042" \
"TAMUni-Tamil046" \
"TAMUni-Tamil150" \
"TAMUni-Tamil195" \
"TAMu_Kadambri" \
"TAMu_Kalyani" \
"TAMu_Maduram" \
"TAU-Achu" \
"TAU-Achu Italic," \
"TAU-Barathi" \
"TAU-Barathi Bold" \
"TAU-Barathi Bold Italic" \
"TAU-Barathi Italic" \
"TAU-Ezhil" \
"TAU-Ezhil Bold, Bold" \
"TAU-Ezhil Italic, Italic" \
"TAU-Kabilar" \
"TAU-Kabilar Bold" \
"TAU-Kabilar Bold Italic" \
"TAU-Kabilar Italic" \
"TAU-Kambar" \
"TAU-Kambar Bold" \
"TAU-Kambar Bold Italic" \
"TAU-Kambar Italic" \
"TAU-Kaveri" \
"TAU-Kaveri Bold" \
"TAU-Kaveri Bold Italic" \
"TAU-Kaveri Italic" \
"TAU-Kurinji" \
"TAU-Kurinji Bold, Bold" \
"TAU-Kurinji Italic, Medium Italic" \
"TAU-Malar" \
"TAU-Malar Bold, Bold" \
"TAU-Malar Italic, Italic" \
"TAU-Marutham" \
"TAU-Marutham Bold," \
"TAU-Marutham Italic," \
"TAU-Mullai Bold, Bold" \
"TAU-Mullai Italic" \
"TAU-Mullai Italic, Italic" \
"TAU-Neythal" \
"TAU-Neythal Bold, Bold" \
"TAU-Neythal Italic, Italic" \
"TAU-Nilavu Bold, Bold" \
"TAU-Nilavu Italic" \
"TAU-Nilavu Italic, Italic" \
"TAU-Paalai" \
"TAU-Paalai Bold, Bold" \
"TAU-Paalai Italic, Italic" \
"TAU-Urai" \
"TAU-Urai Bold," \
"TAU-Urai Italic, Italic" \
"TAU-Valluvar" \
"TAU-Valluvar Bold" \
"TAU-Valluvar Bold Italic" \
"TAU-Valluvar Italic" \
"TAU_Elango_" \
"Vijaya" \
"Vijaya Bold" \
"e-Grantamil" 
  
echo -e "\n***** Making test data for testlayertamil set for layertamil training."
bash src/training/tesstrain.sh --fonts_dir /home/ubuntu/.fonts --lang tam --linedata_only \
  --noextract_font_properties --langdata_dir ../langdata \
  --training_text ../langdata/tam/tam.layertamiltest.training_text \
  --tessdata_dir ./tessdata --output_dir ../tesstutorial/testlayertamil \
  --save_box_tiff \
  --fontlist \
"Arial Unicode MS" \
"FreeSerif" \
"Lohit Tamil" \
"Lohit Tamil Classical" \
"Vijaya" \
"e-Grantamil" 

    
echo -e "\n***** Making evaluation data for evallayertamil set for layertamil training using Impact font."
bash src/training/tesstrain.sh --fonts_dir /home/ubuntu/.fonts --lang tam --linedata_only \
  --noextract_font_properties --langdata_dir ../langdata \
  --training_text ../langdata/tam/tam.layertamileval.training_text \
  --tessdata_dir ./tessdata \
  --output_dir ../tesstutorial/evallayertamil \
   --fontlist \
"Lohit Tamil Classical" \
"e-Grantamil" 

rm -rf ../tesstutorial/tam_layertamil_tam
mkdir -p ../tesstutorial/tam_layertamil_tam

echo -e "\n***** Extract LSTM model from best traineddata for Tamil. \n"
combine_tessdata -e ./tessdata/best/Tamil.traineddata \
  ../tesstutorial/tam_layertamil_tam/tam.lstm
  