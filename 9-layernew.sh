#!/bin/bash

cd ./tesseract

echo -e "\n***** Run lstmtraining for 50000 iterations without debug info for eng using trainlayer training set. \n"
lstmtraining --debug_interval 0 \
  --continue_from ../tesstutorial/eng_layer_eng/eng.lstm \
  --traineddata ../tesstutorial/trainlayer/eng/eng.traineddata \
  --append_index 5 --net_spec '[Lfx256 O1c111]' \
  --model_output ../tesstutorial/eng_layer_eng/layer \
  --train_listfile ../tesstutorial/trainlayer/eng.training_files.txt \
  --eval_listfile ../tesstutorial/evallayer/eng.training_files.txt \
  --max_iterations 50000
  
echo -e "\n***** Your error rates above for eng_layer_eng lstmtraining for first 100 iterations should be similar to the following.\n"
echo -e "Shree's Test on ppc64le: char train=106.009%, word train=100% \n"
echo -e "\n***** Your error rates above for eng_layer_eng lstmtraining for 3000 iterations should be similar to the following.\n"
echo -e "Shree's Test on ppc64le: char train=3.358%, word train=10.691% \n"
echo -e "\n***** Your error rates above for eng_layer_eng lstmtraining for 5000 iterations should be similar to the following.\n"
echo -e "Shree's Test on ppc64le: char train=2.323%, word train=7.635% \n"
echo -e "\n***** Your error rates above for eng_layer_eng lstmtraining for 10000 iterations should be similar to the following.\n"
echo -e "Shree's Test on ppc64le: char train=1.346%, word train=4.523% \n"
echo -e "\n***** Your error rates above for eng_layer_eng lstmtraining for 15000 iterations should be similar to the following.\n"
echo -e "Shree's Test on ppc64le: char train=0.987%, word train=3.256% \n"
echo -e "\n***** Your error rates above for eng_layer_eng lstmtraining for 20000 iterations should be similar to the following.\n"
echo -e "Shree's Test on ppc64le:  char train=0.657%, word train=2.796% \n"
echo -e "\n***** Your error rates above for eng_layer_eng lstmtraining for 30000 iterations should be similar to the following.\n"
echo -e "Shree's Test on ppc64le:  char train=0.544%, word train=2.123% \n"
echo -e "\n***** Your error rates above for eng_layer_eng lstmtraining for 50000 iterations should be similar to the following.\n"
echo -e "Shree's Test on ppc64le: char train=0.319%, word train=1.355%  \n"

echo -e "\n***** lstmeval for independent test on the Impact font using evallayer set with best/eng - for comparison. \n"
echo -e "Shree's Test on ppc64le: Eval Char error rate=154.14868, Word error rate=99.65746 \n"

echo -e "\n***** Run lstmeval for independent test on the Impact font using evallayer set. \n"
lstmeval --model ../tesstutorial/eng_layer_eng/layer_checkpoint \
  --verbosity 0 \
  --traineddata ../tesstutorial/trainlayer/eng/eng.traineddata \
  --eval_listfile ../tesstutorial/evallayer/eng.training_files.txt
echo -e "\n***** Your error rates above for eval of evallayer should be similar to the following.\n"
echo -e "Shree's Test on ppc64le: Eval Char error rate=10.318807, Word error rate=31.464601 \n"

echo -e "\n***** Run lstmeval for test on multiple fonts samples using testlayer set. \n"
lstmeval --model ../tesstutorial/eng_layer_eng/layer_checkpoint \
  --verbosity 0 \
  --traineddata ../tesstutorial/trainlayer/eng/eng.traineddata \
  --eval_listfile ../tesstutorial/testlayer/eng.training_files.txt
echo -e "\n***** Your error rates above for eval of testlayer should be similar to the following.\n"
echo -e "Shree's Test on ppc64le: Eval Char error rate=4.6751999, Word error rate=6.9228114 \n"

echo -e "\n***** Stop lstmtraining and convert to traineddata. \n"
lstmtraining \
  --stop_training \
  --continue_from ../tesstutorial/eng_layer_eng/layer_checkpoint \
  --traineddata ../tesstutorial/trainlayer/eng/eng.traineddata \
  --model_output ../tesstutorial/eng_layer_eng/eng_layer.traineddata

cp   ../tesstutorial/eng_layer_eng/eng_layer.traineddata ./tessdata/best/
echo -e "\n***** You can now use the finetuned traineddata with '-l eng_layer --tessdata-dir ./tessdata/best' \n"

echo -e "\n***** layernew.tif -l eng_layer \n"
time tesseract ../layernew.tif - -l eng_layer --tessdata-dir ./tessdata/best  --psm 6

echo -e "\n***** layernew.tif -l eng \n"
time tesseract ../layernew.tif - -l eng --tessdata-dir ./tessdata/best --psm 6

### echo -e "\n***** layernew-impact.tif -l eng_layer \n"
### time tesseract ../layernew-impact.tif - -l eng_layer --tessdata-dir ./tessdata/best
### 
### 