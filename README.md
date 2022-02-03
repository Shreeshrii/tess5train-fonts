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

### Command used

```
nohup bash finetune_font.sh eng Latin eng engImpact FineTune  ' "Impact Condensed" ' ' "Impact Condensed" ' 0 0 9999 2 > data/logs/engImpact.log &
```

### Plot using log file generated during training
![Plot using log file generated during training](https://github.com/Shreeshrii/tess5train-fonts/blob/main/data/engImpact/plots/engImpact-LOG-2.png)

### Plot from results of various OCR evaluation tools
![Plot from results of various OCR evaluation tools](https://github.com/Shreeshrii/tess5train-fonts/blob/main/data/engImpact/plots/engImpact-2.png)

## engFineTuned

Finetuning of tessdata_best/eng.traineddata for Impact font.
Evaluation done on data using two other fonts.

### Command used

```
nohup bash finetune_font.sh eng Latin eng engFineTuned FineTune  ' "Impact Condensed" ' ' "Arial" "FreeSerif" ' 0 0 9999 2 > data/logs/engFineTuned.log &
```
### Plot using log file generated during training
![Plot using log file generated during training](https://github.com/Shreeshrii/tess5train-fonts/blob/main/data/engFineTuned/plots/engFineTuned-LOG-2.png)

### Plot from results of various OCR evaluation tools
![Plot from results of various OCR evaluation tools](https://github.com/Shreeshrii/tess5train-fonts/blob/main/data/engFineTuned/plots/engFineTuned-2.png)

## engRupee

Finetuning of tessdata_best/eng.traineddata for adding the Indian Rupee symbol using multiple fonts which support the character.
Evaluation done on data using Latin fonts listed in language_specific.py (used when no fonts are specified).

### Command used

```
nohup bash plusminus_char.sh eng Latin eng engRupee FineTune ' "Andika" "Calibri" "Calibri Bold" "Calibri Bold Italic" "Calibri Italic" "Calibri Light" "Calibri Light Italic" "Cambria Bold" "Cambria Bold Italic" "Cambria Italic" "Charis SIL" "Charis SIL Bold" "Charis SIL Bold Italic" "Charis SIL Italic" "Consolas" "Consolas Bold" "Consolas Bold Italic" "Consolas Italic" "Doulos SIL" "FreeMono" "FreeMono Bold" "FreeMono Bold Italic" "FreeMono Italic" "FreeSans" "FreeSans Italic" "FreeSans Semi-Bold" "FreeSans Semi-Bold Italic" "FreeSerif" "FreeSerif Bold" "FreeSerif Bold Italic" "FreeSerif Italic" "Microsoft Sans Serif" "Quivira" "Symbola Semi-Condensed" "Tahoma" "Tahoma Bold" "Times New Roman," "Times New Roman, Bold" "Times New Roman, Bold Italic" "Times New Roman, Italic" "Unifont Medium" ' '' 0 0 99999 2 > data/logs/engRupee.log &
```
### Plot using log file generated during training
![Plot using log file generated during training](https://github.com/Shreeshrii/tess5train-fonts/blob/main/data/engRupee/plots/engRupee-LOG-2.png)

### Plot from results of various OCR evaluation tools
![Plot from results of various OCR evaluation tools](https://github.com/Shreeshrii/tess5train-fonts/blob/main/data/engRupee/plots/engRupee-2.png)

## engLayer

Replace the top layer of network of tessdata_best/eng.traineddata for adding multiple characters such as superscripts, fraction symbols, etc using multiple fonts which support the characters.
Evaluation done on data using Latin fonts listed in language_specific.py (used when no fonts are specified).

### Fonts used

```
' "Alexander" "Anaktoria" "Andika" "Aroania" "Asea" "Asea Bold" "Asea Bold Italic" "Asea Italic" "Avdira" "Calibri" "Calibri Bold" "Calibri Bold Italic" "Calibri Italic" "Calibri Light" "Calibri Light Italic" "Cambria Bold" "Cambria Bold Italic" "Cambria Italic" "Charis SIL" "Charis SIL Bold" "Charis SIL Bold Italic" "Charis SIL Italic" "Consolas" "Consolas Bold" "Consolas Bold Italic" "Consolas Italic" "Doulos SIL" "FreeMono" "FreeMono Bold" "FreeMono Bold Italic" "FreeMono Italic" "FreeSans" "FreeSans Italic" "FreeSans Semi-Bold" "FreeSans Semi-Bold Italic" "FreeSerif" "FreeSerif Bold" "FreeSerif Bold Italic" "FreeSerif Italic" "Microsoft Sans Serif" "Noto Sans" "Noto Sans Bold" "Noto Sans Bold Italic" "Noto Sans Display" "Noto Sans Display Bold" "Noto Sans Display Bold Italic" "Noto Sans Display Italic" "Noto Sans Italic" "Noto Sans Mono" "Noto Sans Mono Bold" "Noto Serif" "Noto Serif Bold" "Noto Serif Bold Italic" "Noto Serif Display" "Noto Serif Display Bold" "Noto Serif Display Bold Italic" "Noto Serif Display Italic" "Noto Serif Italic" "Quivira" "Segoe UI Heavy" "Segoe UI Heavy Italic" "Segoe UI Light" "Segoe UI Semi-Bold" "Segoe UI Semi-Light" "Symbola Semi-Condensed" "Tahoma" "Tahoma Bold" "Times New Roman," "Times New Roman, Bold" "Times New Roman, Bold Italic" "Times New Roman, Italic" "Unifont Medium" '
```
### Plot using log file generated during training
![Plot using log file generated during training](https://github.com/Shreeshrii/tess5train-fonts/blob/main/data/engLayer/plots/engLayer-LOG-5.png)

### Plot from results of various OCR evaluation tools
![Plot from results of various OCR evaluation tools](https://github.com/Shreeshrii/tess5train-fonts/blob/main/data/engLayer/plots/engLayer-5.png)
