#!/bin/bash

cd ./tesseract

rm -rf  ../tesstutorial/impact_from_full
mkdir ../tesstutorial/impact_from_full

echo -e "\n***** Extract LSTM model from best traineddata. \n"
combine_tessdata -e tessdata/best/eng.traineddata \
  ../tesstutorial/impact_from_full/eng.lstm

echo -e "\n***** Run lstmtraining with debug output for first 100 iterations. \n"
lstmtraining \
  --model_output ../tesstutorial/impact_from_full/impact \
  --continue_from ../tesstutorial/impact_from_full/eng.lstm \
  --traineddata tessdata/best/eng.traineddata \
  --train_listfile ../tesstutorial/engeval/eng.training_files.txt \
  --debug_interval -1 \
  --max_iterations 100
echo -e "\n***** Your error rates above for first 100 iterations should be similar to the following.\n"
echo -e "Ray's Result at Google: 1.35%/4.56% char/word error  \n"
echo -e "Shree's Test on ppc64le:  char train=1.024%, word train=3.259% \n"

echo -e "\n***** Continue lstmtraining till 400 iterations. \n"
lstmtraining \
  --model_output ../tesstutorial/impact_from_full/impact \
  --continue_from ../tesstutorial/impact_from_full/eng.lstm \
  --traineddata tessdata/best/eng.traineddata \
  --train_listfile ../tesstutorial/engeval/eng.training_files.txt \
  --debug_interval 0 \
  --max_iterations 400
echo -e "\n***** Your error rates above for 400 iterations of lstmtraining should be similar to the following.\n"
echo -e "Ray's Result at Google: 0.533%/1.633%  char/word error \n"
echo -e "Shree's Test on ppc64le:  char train=0.31%, word train=0.959% \n"

echo -e "\n***** Run lstmeval on engeval set. \n"
lstmeval \
  --verbosity 0 \
  --model ../tesstutorial/impact_from_full/impact_checkpoint \
  --traineddata tessdata/best/eng.traineddata \
  --eval_listfile ../tesstutorial/engeval/eng.training_files.txt
echo -e "\n***** Your eval error rates above for eval for engeval should be similar to the following.\n"
echo -e "Ray's Result at Google: Char error 0.017%, word 0.120% \n"
echo -e "Shree's Test on ppc64le:  Eval Char error rate=0.014619883, Word error rate=0.073099415 \n"

echo -e "\n***** Run lstmeval on engtrain set. \n"
lstmeval \
  --verbosity 0 \
  --model ../tesstutorial/impact_from_full/impact_checkpoint \
  --traineddata tessdata/best/eng.traineddata \
  --eval_listfile ../tesstutorial/engtrain/eng.training_files.txt
echo -e "\n***** Your error rates above for eval of engtrain should be similar to the following.\n"
echo -e "Ray's Result at Google: Char error rate=0.25548592, Word error rate=0.82523491 \n"
echo -e "Shree's Test on ppc64le:  Eval Char error rate=0.27672804, Word error rate=0.64643663 \n"

echo -e "\n***** Stop lstmtraining and convert to traineddata. \n"
lstmtraining \
  --stop_training \
  --continue_from ../tesstutorial/impact_from_full/impact_checkpoint \
  --traineddata tessdata/best/eng.traineddata \
  --model_output ../tesstutorial/impact_from_full/eng_impact.traineddata

cp   ../tesstutorial/impact_from_full/eng_impact.traineddata ./tessdata/best/
echo -e "\n***** You can now use the finetuned traineddata with '-l eng_impact --tessdata-dir ./tessdata/best' \n"

echo -e "\n***** Stop lstmtraining and convert to integer traineddata. \n"
lstmtraining \
  --stop_training \
  --convert_to_int \
  --continue_from ../tesstutorial/impact_from_full/impact_checkpoint \
  --traineddata tessdata/best/eng.traineddata \
  --model_output ../tesstutorial/impact_from_full/eng_impact_int.traineddata

cp   ../tesstutorial/impact_from_full/eng_impact_int.traineddata ./tessdata/best/
echo -e "\n***** You can now use the finetuned integer traineddata with '-l eng_impact_int --tessdata-dir ./tessdata/best' \n"

time tesseract ../phototest-impact.tif - -l eng_impact --tessdata-dir ./tessdata/best

time tesseract ../phototest-impact.tif - -l eng --tessdata-dir ./tessdata/best


