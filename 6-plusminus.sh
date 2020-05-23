#!/bin/bash

cd ./tesseract

echo -e "\n***** Run lstmtraining with debug output for first 100 iterations. \n"
lstmtraining --model_output ../tesstutorial/trainplusminus/plusminus \
  --continue_from ../tesstutorial/trainplusminus/eng.lstm \
  --traineddata ../tesstutorial/trainplusminus/eng/eng.traineddata \
  --old_traineddata tessdata/best/eng.traineddata \
  --train_listfile ../tesstutorial/trainplusminus/eng.training_files.txt \
  --debug_interval -1 \
  --max_iterations 100
echo -e "Past Result Range"
echo -e "Ray's Result at Google: 1.26%/3.98% char/word error \n"
echo -e "Shree's Test on ppc64le:  char train=0.541%, word train=1.748% \n"

echo -e "\n***** Remove plusminus*checkpoints . \n"
rm ../tesstutorial/trainplusminus/plusminus*checkpoint

echo -e "\n***** Restart lstmtraining till 3600 iterations. \n"
lstmtraining --model_output ../tesstutorial/trainplusminus/plusminus \
  --continue_from ../tesstutorial/trainplusminus/eng.lstm \
  --traineddata ../tesstutorial/trainplusminus/eng/eng.traineddata \
  --old_traineddata tessdata/best/eng.traineddata \
  --train_listfile ../tesstutorial/trainplusminus/eng.training_files.txt \
  --max_iterations 3600
echo -e "Past Result Range"
echo -e "Ray's Result at Google: 0.041%/0.185% char/word error \n"
echo -e "Shree's Test on ppc64le: char train=0.026%, word train=0.08% \n"

echo -e "\n***** Run lstmeval on trainplusminus set. \n"
lstmeval --model ../tesstutorial/trainplusminus/plusminus_checkpoint \
  --verbosity 0 \
  --traineddata ../tesstutorial/trainplusminus/eng/eng.traineddata \
  --eval_listfile ../tesstutorial/trainplusminus/eng.training_files.txt
echo -e "Past Result Range"
echo -e "Ray's Result at Google: Char error 0.0326%, word 0.128% \n"
echo -e "Shree's Test on ppc64le:  Eval Char error rate=0.014645373, Word error rate=0.036469851 \n"

echo -e "\n***** Run lstmeval on evalplusminus set - Impact Font. \n"
lstmeval --model ../tesstutorial/trainplusminus/plusminus_checkpoint \
  --verbosity 0 \
  --traineddata ../tesstutorial/trainplusminus/eng/eng.traineddata \
  --eval_listfile ../tesstutorial/evalplusminus/eng.training_files.txt
echo -e "Past Result Range"
echo -e "Ray's Result at Google: Char error rate=2.3767074, Word error rate=8.3829474 \n"
echo -e "Shree's Test on ppc64le:  Eval Char error rate=3.8430058, Word error rate=10.827586 \n"

echo -e "\n***** Run lstmeval on evalplusminus set - Impact Font and grep ±. \n"
lstmeval --model ../tesstutorial/trainplusminus/plusminus_checkpoint \
  --traineddata ../tesstutorial/trainplusminus/eng/eng.traineddata \
  --eval_listfile ../tesstutorial/evalplusminus/eng.training_files.txt \
  --verbosity 2  2>&1 |   grep ±

echo -e "\n***** Stop lstmtraining and convert to traineddata. \n"
lstmtraining \
  --stop_training \
  --continue_from ../tesstutorial/trainplusminus/plusminus_checkpoint \
  --traineddata ../tesstutorial/trainplusminus/eng/eng.traineddata \
  --model_output ../tesstutorial/trainplusminus/eng_plusminus.traineddata

cp   ../tesstutorial/trainplusminus/eng_plusminus.traineddata ./tessdata/best/

time tesseract ../phototest.tif - -l eng_plusminus --tessdata-dir ./tessdata/best

echo -e "You can now use the finetuned traineddata with '-l eng_plusminus --tessdata-dir ./tessdata/best' \n"

echo -e "\n***** Stop lstmtraining and convert to integer/faster traineddata. \n"
lstmtraining \
  --stop_training \
  --convert_to_int \
  --continue_from ../tesstutorial/trainplusminus/plusminus_checkpoint \
  --traineddata ../tesstutorial/trainplusminus/eng/eng.traineddata \
  --model_output ../tesstutorial/trainplusminus/eng_plusminus_int.traineddata

cp   ../tesstutorial/trainplusminus/eng_plusminus_int.traineddata ./tessdata/best/

time tesseract ../phototest.tif - -l eng_plusminus_int --tessdata-dir ./tessdata/best

echo -e "You can now use the finetuned integer traineddata with '-l eng_plusminus_int --tessdata-dir ./tessdata/best' \n"
