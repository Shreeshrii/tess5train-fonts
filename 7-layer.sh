#!/bin/bash

cd ./tesseract

echo -e "\n***** Run lstmtraining for 3000 iterations for eng using engtrain training set. \n"
lstmtraining --debug_interval 0 \
  --continue_from ../tesstutorial/eng_from_chi/eng.lstm \
  --traineddata ../tesstutorial/engtrain/eng/eng.traineddata \
  --append_index 5 --net_spec '[Lfx256 O1c111]' \
  --model_output ../tesstutorial/eng_from_chi/base \
  --train_listfile ../tesstutorial/engtrain/eng.training_files.txt \
  --eval_listfile ../tesstutorial/engeval/eng.training_files.txt \
  --max_iterations 3000 
echo -e "\n***** Your error rates above for eng_from_chi lstmtraining should be similar to the following.\n"
echo -e "Ray's Result at Google:  6.00% character/22.42% word. \n"
echo -e "Shree's Test on ppc64le: char train=4.28%, word train=12.667% \n"

echo -e "\n***** Run lstmeval on the full training set engtrain after eng_from_chi lstmtraining. \n"
lstmeval --model ../tesstutorial/eng_from_chi/base_checkpoint \
  --verbosity 0 \
  --traineddata ../tesstutorial/engtrain/eng/eng.traineddata \
  --eval_listfile ../tesstutorial/engtrain/eng.training_files.txt
echo -e "\n***** Your error rates above for eval of engtrain should be similar to the following.\n"
echo -e "Ray's Result at Google: 5.557%/20.43% \n"
echo -e "Shree's Test on ppc64le: Eval Char error rate=3.2640259, Word error rate=10.341771 \n"
  
echo -e "\n***** Run lstmeval for independent test on the Impact font using engeval set after eng_from_chi lstmtraining. \n"
lstmeval --model ../tesstutorial/eng_from_chi/base_checkpoint \
  --verbosity 0 \
  --traineddata ../tesstutorial/engtrain/eng/eng.traineddata \
  --eval_listfile ../tesstutorial/engeval/eng.training_files.txt
echo -e "\n***** Your error rates above for eval of engeval should be similar to the following.\n"
echo -e "Ray's Result at Google: 36.67%/83.23% \n"
echo -e "Shree's Test on ppc64le: Eval Char error rate=32.113866, Word error rate=66.114791 \n"
