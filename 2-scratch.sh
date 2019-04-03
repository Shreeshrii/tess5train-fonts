#!/bin/bash

cd ./tesseract

echo -e "\n***** Run lstmtraining for 5000 iterations. \n"
lstmtraining --debug_interval 0 \
  --traineddata ../tesstutorial/engtrain/eng/eng.traineddata \
  --net_spec '[1,36,0,1 Ct3,3,16 Mp3,3 Lfys48 Lfx96 Lrx96 Lfx256 O1c111]' \
  --model_output ../tesstutorial/engoutput/base --learning_rate 20e-4 \
  --train_listfile ../tesstutorial/engtrain/eng.training_files.txt \
  --eval_listfile ../tesstutorial/engeval/eng.training_files.txt \
  --max_iterations 5000
echo -e "\n***** Your error rates above for 5000 iterations of lstmtraining should be similar to the following.\n"
echo -e "Ray's Result at Google: 5000 iterations - char error 13% \n"
echo -e "Shree's Test on ppc64le: 5000 iterations - char train=2.666%, word train=7.116% \n"

echo -e "\n***** Run lstmeval on engeval set on checkpoint after 5000 iterations . \n"
lstmeval --model ../tesstutorial/engoutput/base_checkpoint \
  --verbosity 0 \
  --traineddata ../tesstutorial/engtrain/eng/eng.traineddata \
  --eval_listfile ../tesstutorial/engeval/eng.training_files.txt
echo -e "\n***** Your eval error rates above for evaluation of engeval for the lstmtraining checkpoint after 5000 iterations should be similar to the following.\n"
echo -e "Ray's Result at Google: 85% character error rate \n"
echo -e "Shree's Test on ppc64le:  Eval Char error rate=115.54428, Word error rate=99.479741 \n"

echo -e "\n***** Run lstmeval on engeval set for tessdata/best. \n"
lstmeval --model tessdata/best/eng.traineddata \
  --verbosity 0 \
  --eval_listfile ../tesstutorial/engeval/eng.training_files.txt
echo -e "\n***** Your eval error rates above for evaluation of engeval with tessdata/best should be similar to the following.\n"
echo -e "Ray's Result at Google: 2.45% character error rate \n"
echo -e "Shree's Test on ppc64le:  Eval Char error rate=2.7322011, Word error rate=8.5484687 \n"

echo -e "\n***** Run lstmeval on engtrain set for tessdata/best. \n"
lstmeval --model tessdata/best/eng.traineddata \
  --verbosity 0 \
  --eval_listfile ../tesstutorial/engtrain/eng.training_files.txt
echo -e "\n***** Your eval error rates above for evaluation of engtrain with tessdata/best should be similar to the following.\n"
echo -e "Ray's Result at Google: Char error rate=0.25047642, Word error rate=0.63389585 \n"
echo -e "Shree's Test on ppc64le:  Eval Char error rate=0.21652867, Word error rate=0.52803284 \n"

echo -e "\n***** Continue lstmtraining till 10000 iterations. \n"
lstmtraining --debug_interval 0 \
  --traineddata ../tesstutorial/engtrain/eng/eng.traineddata \
  --net_spec '[1,36,0,1 Ct3,3,16 Mp3,3 Lfys48 Lfx96 Lrx96 Lfx256 O1c111]' \
  --model_output ../tesstutorial/engoutput/base --learning_rate 20e-4 \
  --train_listfile ../tesstutorial/engtrain/eng.training_files.txt \
  --eval_listfile ../tesstutorial/engeval/eng.training_files.txt \
  --max_iterations 10000
echo -e "\n***** Your error rates above for 10000 iterations of lstmtraining should be similar to the following.\n"
echo -e "Ray's Result at Google: 2.68% character / 10.01% word \n"
echo -e "Shree's Test on ppc64le:  char train=0.894%, word train=2.717% \n"

echo -e "\n***** Run lstmeval on engeval set on checkpoint after 10000 iterations . \n"
lstmeval --model ../tesstutorial/engoutput/base_checkpoint \
  --verbosity 0 \
  --traineddata ../tesstutorial/engtrain/eng/eng.traineddata \
  --eval_listfile ../tesstutorial/engeval/eng.training_files.txt
echo -e "\n***** Your eval error rates above for evaluation of engeval for the lstmtraining checkpoint after 10000 iterations should be similar to the following.\n"
echo -e "Ray's Result at Google: Character error rate on Impact now >100% - OVERFITTED. \n"
echo -e "Shree's Test on ppc64le:  Eval Char error rate=88.197982, Word error rate=98.444517 \n"
