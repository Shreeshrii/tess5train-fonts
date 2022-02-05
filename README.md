# tess5train-fonts

**THIS IS A WORK IN PROCESS.**

Creation of training data, running of training and plotting of error rates based on different ocr evaluation methods.

Training related scripts are based on Makefile and python scripts in [tesstrain](https://github.com/tesseract-ocr/tesstrain) repo.

MatPlotLib is used to visualize the CER from training iterations, checkpoints, evaluation test and subtrainers.

OCR evalation tools:
* [ISRI Analytic Tools for OCR Evaluation with UTF-8 support](https://github.com/eddieantonio/ocreval) 
* [The ocrevalUAtion tool](https://sites.google.com/site/textdigitisation/ocrevaluation)
* [lstmeval from tesseract](https://github.com/tesseract-ocr/tesseract/blob/main/doc/lstmeval.1.asc)

## engImpact

Finetuning of tessdata_best/eng.traineddata for Impact font.
Evaluation done on data using same font

>A pre-trained model can be fine-tuned or adapted to a small data set, without doing a lot of harm to its general accuracy. It is still very important however, to avoid over-fitting.

>Note that further training beyond 400 iterations makes the error on the base set higher.

### Command used

```
nohup bash finetune_font.sh eng Latin eng engImpact FineTune  ' "Impact Condensed" ' ' "Impact Condensed" ' 0 0 9999 1 > data/logs/engImpact.log &
```

### Plot from results of various OCR evaluation tools
![Plot from results of various OCR evaluation tools](https://github.com/Shreeshrii/tess5train-fonts/blob/main/data/engImpact/plots/engImpact-1.png)

## engFineTuned

Finetuning of tessdata_best/eng.traineddata for Impact font.
Evaluation done on data using two other fonts.

>A pre-trained model can be fine-tuned or adapted to a small data set, without doing a lot of harm to its general accuracy. It is still very important however, to avoid over-fitting.

>Note that further training beyond 400 iterations makes the error on the base set higher.

### Command used

```
nohup bash finetune_font.sh eng Latin eng engFineTuned FineTune  ' "Impact Condensed" ' ' "Arial" "FreeSerif" ' 0 0 9999 1 > data/logs/engFineTuned.log &
```

### Plot from results of various OCR evaluation tools
![Plot from results of various OCR evaluation tools](https://github.com/Shreeshrii/tess5train-fonts/blob/main/data/engFineTuned/plots/engFineTuned-1.png)

## engRupee

Finetuning of tessdata_best/eng.traineddata for adding the Indian Rupee symbol using multiple fonts which support the character.
Evaluation done on data using Latin fonts listed in language_specific.py (used when no fonts are specified).

>It is possible to add a few new characters to the character set and train for them by fine tuning, without a large amount of training data ... without impacting existing accuracy, and the ability to recognize the new character will, to some extent at least, generalize to other fonts!

>NOTE: When fine tuning, it is important to experiment with the number of iterations, since excessive training on a small data set will cause over-fitting. ADAM, is great for finding the feature combinations necessary to get that rare class correct, but it does seem to overfit more than simpler optimizers.

### Command used

```
nohup bash plusminus_char.sh eng Latin eng engRupee FineTune ' "Andika" "Calibri" "Calibri Bold" "Calibri Bold Italic" "Calibri Italic" "Calibri Light" "Calibri Light Italic" "Cambria Bold" "Cambria Bold Italic" "Cambria Italic" "Charis SIL" "Charis SIL Bold" "Charis SIL Bold Italic" "Charis SIL Italic" "Consolas" "Consolas Bold" "Consolas Bold Italic" "Consolas Italic" "Doulos SIL" "FreeMono" "FreeMono Bold" "FreeMono Bold Italic" "FreeMono Italic" "FreeSans" "FreeSans Italic" "FreeSans Semi-Bold" "FreeSans Semi-Bold Italic" "FreeSerif" "FreeSerif Bold" "FreeSerif Bold Italic" "FreeSerif Italic" "Microsoft Sans Serif" "Quivira" "Symbola Semi-Condensed" "Tahoma" "Tahoma Bold" "Times New Roman," "Times New Roman, Bold" "Times New Roman, Bold Italic" "Times New Roman, Italic" "Unifont Medium" ' '' 0 0 99999 1 > data/logs/engRupee.log &
```

### Plot from results of various OCR evaluation tools
![Plot from results of various OCR evaluation tools](https://github.com/Shreeshrii/tess5train-fonts/blob/main/data/engRupee/plots/engRupee-1.png)

## engLayer

Replace the top layer of network of tessdata_best/eng.traineddata for adding multiple characters such as superscripts, fraction symbols, etc using multiple fonts which support the characters.
Evaluation done on data using the same fonts.

>For replacing the top layer, we will cut off the last LSTM layer and the softmax, replacing with a smaller LSTM layer and a new softmax.

>For a new language, it is possible to cut off the top layers of an existing network and train, as if from scratch, but a fairly large amount of training data is still required to avoid over-fitting.

### Command Used

This training and plotting was run using an older version of the scripts.

### Fonts used

```
' "Alexander" "Anaktoria" "Andika" "Aroania" "Asea" "Asea Bold" "Asea Bold Italic" "Asea Italic" "Avdira" "Calibri" "Calibri Bold" "Calibri Bold Italic" "Calibri Italic" "Calibri Light" "Calibri Light Italic" "Cambria Bold" "Cambria Bold Italic" "Cambria Italic" "Charis SIL" "Charis SIL Bold" "Charis SIL Bold Italic" "Charis SIL Italic" "Consolas" "Consolas Bold" "Consolas Bold Italic" "Consolas Italic" "Doulos SIL" "FreeMono" "FreeMono Bold" "FreeMono Bold Italic" "FreeMono Italic" "FreeSans" "FreeSans Italic" "FreeSans Semi-Bold" "FreeSans Semi-Bold Italic" "FreeSerif" "FreeSerif Bold" "FreeSerif Bold Italic" "FreeSerif Italic" "Microsoft Sans Serif" "Noto Sans" "Noto Sans Bold" "Noto Sans Bold Italic" "Noto Sans Display" "Noto Sans Display Bold" "Noto Sans Display Bold Italic" "Noto Sans Display Italic" "Noto Sans Italic" "Noto Sans Mono" "Noto Sans Mono Bold" "Noto Serif" "Noto Serif Bold" "Noto Serif Bold Italic" "Noto Serif Display" "Noto Serif Display Bold" "Noto Serif Display Bold Italic" "Noto Serif Display Italic" "Noto Serif Italic" "Quivira" "Segoe UI Heavy" "Segoe UI Heavy Italic" "Segoe UI Light" "Segoe UI Semi-Bold" "Segoe UI Semi-Light" "Symbola Semi-Condensed" "Tahoma" "Tahoma Bold" "Times New Roman," "Times New Roman, Bold" "Times New Roman, Bold Italic" "Times New Roman, Italic" "Unifont Medium" '
```
### Plot using log file generated during training
![Plot using log file generated during training](https://github.com/Shreeshrii/tess5train-fonts/blob/main/data/engLayer/plots/engLayer-LOG-10.png)

### Plot from results of various OCR evaluation tools
![Plot from results of various OCR evaluation tools](https://github.com/Shreeshrii/tess5train-fonts/blob/main/data/engLayer/plots/engLayer-10.png)
