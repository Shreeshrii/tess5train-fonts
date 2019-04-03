#!/bin/bash

cd ./tesseract

echo -e "\n***** Run lstmtraining with debug output for first 100 iterations. \n"
lstmtraining --model_output ../tesstutorial/impact_from_small/impact \
  --continue_from ../tesstutorial/engoutput/base_checkpoint \
  --traineddata ../tesstutorial/engtrain/eng/eng.traineddata \
  --train_listfile ../tesstutorial/engeval/eng.training_files.txt \
  --debug_interval -1 \
  --max_iterations 100
echo -e "\n***** Your error rates above for first 100 iterations should be similar to the following.\n"
echo -e "Ray's Result at Google: character/word error is 22.36%/50.0%  \n"
echo -e "Shree's Test on ppc64le:  char train=14.07%, word train=28.673% \n"

lstmtraining --model_output ../tesstutorial/impact_from_small/impact \
  --continue_from ../tesstutorial/engoutput/base_checkpoint \
  --traineddata ../tesstutorial/engtrain/eng/eng.traineddata \
  --train_listfile ../tesstutorial/engeval/eng.training_files.txt \
  --max_iterations 1200
echo -e "\n***** Your error rates above for 1200 iterations of lstmtraining should be similar to the following.\n"
echo -e "Ray's Result at Google: character/word error is 0.3%/1.2% \n"
echo -e "Shree's Test on ppc64le: char train=0.045%, word train=0.215% \n"

lstmeval --model ../tesstutorial/impact_from_small/impact_checkpoint \
  --traineddata ../tesstutorial/engtrain/eng/eng.traineddata \
  --eval_listfile ../tesstutorial/engeval/eng.training_files.txt
echo -e "\n***** Your eval error rates above for eval for engeval should be similar to the following.\n"
echo -e "Ray's Result at Google: character/word error is 0.0086%/0.057% \n"
echo -e "Shree's Test on ppc64le:  Eval Char error rate=0.015605493, Word error rate=0.077160494 \n"
