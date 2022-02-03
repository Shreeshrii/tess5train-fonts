# tess5train-fonts

Creation of training data, running of training and plotting of error rates based on different ocr evaluation methods.

Training related scripts are based on Makefile and python scripts in [tesstrain](https://github.com/tesseract-ocr/tesstrain) repo.

MatPlotLib is used to visualize the CER from training iterations, checkpoints, evaluation test and subtrainers.

OCR evalation tools:
* [ISRI Analytic Tools for OCR Evaluation with UTF-8 support](https://github.com/eddieantonio/ocreval) 
* [The ocrevalUAtion tool](https://sites.google.com/site/textdigitisation/ocrevaluation)
* [lstmeval from tesseract](https://github.com/tesseract-ocr/tesseract/blob/main/doc/lstmeval.1.asc)

## engImpact

Finetuning of tessdata_best/eng.traineddata for Impact font
Evaluation done on data using same font

![Plot generated from log file generated during training](https://github.com/Shreeshrii/tess5train-fonts/blob/main/data/engImpact/plots/engImpact-LOG-2.png)

![Plot generated from results of various OCR evaluation tools](https://github.com/Shreeshrii/tess5train-fonts/blob/main/data/engImpact/plots/engImpact-2.png)
