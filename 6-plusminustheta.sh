#!/bin/bash

cd ./tesseract

echo -e "\n***** Run lstmtraining with debug output for first 100 iterations. \n"
lstmtraining --model_output ../tesstutorial/trainplusminustheta/plusminustheta \
  --continue_from ../tesstutorial/trainplusminustheta/eng.lstm \
  --traineddata ../tesstutorial/trainplusminustheta/eng/eng.traineddata \
  --old_traineddata tessdata/best/eng.traineddata \
  --train_listfile ../tesstutorial/trainplusminustheta/eng.training_files.txt \
  --debug_interval -1 \
  --max_iterations 100

echo -e "\n***** Continue lstmtraining till 3600 iterations. \n"
lstmtraining --model_output ../tesstutorial/trainplusminustheta/plusminustheta \
  --continue_from ../tesstutorial/trainplusminustheta/eng.lstm \
  --traineddata ../tesstutorial/trainplusminustheta/eng/eng.traineddata \
  --old_traineddata tessdata/best/eng.traineddata \
  --train_listfile ../tesstutorial/trainplusminustheta/eng.training_files.txt \
  --max_iterations 3600

echo -e "\n***** Run lstmeval on trainplusminustheta set. \n"
lstmeval --model ../tesstutorial/trainplusminustheta/plusminustheta_checkpoint \
  --verbosity 0 \
  --traineddata ../tesstutorial/trainplusminustheta/eng/eng.traineddata \
  --eval_listfile ../tesstutorial/trainplusminustheta/eng.training_files.txt

echo -e "\n***** Run lstmeval on evalplusminustheta set - Impact Font. \n"
lstmeval --model ../tesstutorial/trainplusminustheta/plusminustheta_checkpoint \
  --verbosity 0 \
  --traineddata ../tesstutorial/trainplusminustheta/eng/eng.traineddata \
  --eval_listfile ../tesstutorial/evalplusminustheta/eng.training_files.txt

echo -e "\n***** Run lstmeval on evalplusminustheta set - Impact Font and grep ø theta. \n"
lstmeval --model ../tesstutorial/trainplusminustheta/plusminustheta_checkpoint \
  --traineddata ../tesstutorial/trainplusminustheta/eng/eng.traineddata \
  --eval_listfile ../tesstutorial/evalplusminustheta/eng.training_files.txt \
  --verbosity 2  2>&1 |   grep ø

echo -e "\n***** Stop lstmtraining and convert to traineddata. \n"
lstmtraining \
  --stop_training \
  --continue_from ../tesstutorial/trainplusminustheta/plusminustheta_checkpoint \
  --traineddata ../tesstutorial/trainplusminustheta/eng/eng.traineddata \
  --model_output ../tesstutorial/trainplusminustheta/eng_plusminustheta.traineddata

cp   ../tesstutorial/trainplusminustheta/eng_plusminustheta.traineddata ./tessdata/best/

time tesseract ../phototest.tif - -l eng_plusminustheta --tessdata-dir ./tessdata/best

echo -e "You can now use the finetuned traineddata with '-l eng_plusminustheta --tessdata-dir ./tessdata/best' \n"

echo -e "\n***** Stop lstmtraining and convert to integer/faster traineddata. \n"
lstmtraining \
  --stop_training \
  --convert_to_int \
  --continue_from ../tesstutorial/trainplusminustheta/plusminustheta_checkpoint \
  --traineddata ../tesstutorial/trainplusminustheta/eng/eng.traineddata \
  --model_output ../tesstutorial/trainplusminustheta/eng_plusminustheta_int.traineddata

cp   ../tesstutorial/trainplusminustheta/eng_plusminustheta_int.traineddata ./tessdata/best/

time tesseract ../phototest.tif - -l eng_plusminustheta_int --tessdata-dir ./tessdata/best

echo -e "You can now use the finetuned integer traineddata with '-l eng_plusminustheta_int --tessdata-dir ./tessdata/best' \n"
