# tess4training
LSTM Training Tutorial for Tesseract 4

In order to successfully run the Tesseract 4 Tutorial, you need to have a working installation of Tesseract 4
and Tesseract 4 Training Tools and also have the training scripts and required traineddata files in certain directories.
For running Tesseract 4, it is useful, but not essential to have a multi-core (4 is good) machine, with OpenMP
and Intel Intrinsics support for SSE/AVX extensions. Basically it will still run on anything with enough memory,
but the higher-end your processor is, the faster it will go.

## Setup

This repo sets up the basic files setup and provides the bash scripts
for running Tesseract 4 Training Tutorials described in [Tesseract Wiki
page on LSTM Training](https://github.com/tesseract-ocr/tesseract/wiki/TrainingTesseract-4.00).
Please read the wiki page for details about Tesseract 4 LSTM training process.

You need to have Tessearct 4 installed on your system before you can run these. Please
see [Tesseract Wiki Home page](https://github.com/tesseract-ocr/tesseract/wiki) for
instructions on how to get and install Tesseract 4 on your system.

Please note that only traineddata files from [tessdata_best](https://github.com/tesseract-ocr/tessdata_best/)
can be used as a base for further training. The `integer` models in [tessdata](https://github.com/tesseract-ocr/tessdata) and
[tessdata_fast](https://github.com/tesseract-ocr/tessdata_fast) can not be used for this purpose and will
cause an assertion.

### 0-setup.sh

Do NOT run 0-setup.sh, it is there just as documentation of the steps taken to
set up the training environment.

### Fonts Setup

The fonts needed for Tesstutorial must be installed first, if not already available on your system.
Otherwise the training script will not find the required fonts and fail.

```
sudo apt update
sudo apt install ttf-mscorefonts-installer
sudo apt install fonts-dejavu
sudo apt install fonts-liberation
sudo apt install ttf-bitstream-vera
fc-cache -vf
```

## Tesstutorial Training Scripts (bash)

These are slightly modified versions of the bash commands given in [Tesseract Wiki
page on LSTM Training](https://github.com/tesseract-ocr/tesseract/wiki/TrainingTesseract-4.00).

The scripts do not use `--debug_interval 100` for visual monitoring of LSTM training
described in the wiki page which requires
[scrollview.jar](https://github.com/tesseract-ocr/tesseract/wiki/ViewerDebugging).
Instead `--debug_level -1` is used for first 100 iterations which displays debug info
for every iteration. For the rest, the default `--debug_level 0` applies which outputs
info every 100 iterations.

The resulting character and word error rates for each command can vary slightly based on
the hardware and compiler used. In fact, the randomized round robin method of LSTM training
leads to different results on the same hardware/software environment, specially for low level of iterations.
The error rates noted in the wiki by Ray Smith from the test run at Google as well
as those from a test run on `ppc64le` are displayed for easy comparison with the results
from the current test run. Ray's tests were run using Tesseract 4.0.0 alpha code while
Shree's tests on ppc64le were run using Tesseract 4.1.0 rc1 code. Console log files
corresponding to the training scripts for the latest ppc64le run are also made available for reference.

Please review the bash scripts, log files as well as the training wiki to get familiar with the
LSTM training process, before running these.

### 1-makedata.sh

Mandatory step for creating the `training data` (engtrain) and `evaluation data` (engeval) used
for scratch and impact training.

### 2-scratch.sh

This script is for running training for `eng` starting from scratch. Please note that this uses
a very small training text and is only for illustrating training process when starting from scratch.
This script can take a while to run.

### 3-impact_from_small.sh

This script is for running LSTM training for `finetuning` an existing traineddata for a new font.
This type of training requires minimal training data and limited iterations. This particular training
script uses the traineddata created by `2-scratch.sh` as base to finetune for `Impact` font.
This is also only for illustration purposes.

### 4-impact_from_full.sh

This script is for running LSTM training for `finetuning` an existing traineddata for a new font.
This type of training requires minimal training data and limited iterations. This training uses
`best` traineddata as the base for finetuning and results in improved accuracy for the
`Impact` font in the finetuned traineddata.

### 5-makedata_plusminus.sh
Mandatory step for creating the `training data` (trainplusminus) and `eval data` (evalplusminus)
used by the training script for plusminus training, which adds the `±` character to the unicharset.

### 6-plusminus.sh
This script is for running LSTM training for `finetuning` an existing traineddata for adding a few
characters to the unicharset. This type of training requires more iterations. This training uses
`best` traineddata as the base for finetuning and results in improved accuracy by recognizing
the newly added `±` character when using this finetuned traineddata.

### 7-layer.sh

This script is for running LSTM training for replacing the top layer in an existing traineddata
when major changes are required in the unicharset to be recognized. This type of training requires a
much larger training text and many more iterations. This training also uses
`best` traineddata as the base for finetuning. Using this, it is possible to cut off the top layers of an
existing network and train, as if from scratch, but a fairly large amount of training data is still
required to avoid over-fitting.

This particular training uses `chi_sim` as the base language and trains for `eng` by
replacing the top layer in the network spec, using `engtrain` training set for 3000 iterations. This is
also only for illustration purposes as it uses a small training_text and not enough iterations.

## Additional Training Scripts - Replace Top layer (bash)

These scripts try to provide a real life example of cases where a language traineddata needs
to be extended by many characters which might not work very well with the plusminus type of 
finetuning described above.

In this case, `eng` traineddata is being extended to recognize the Rupee sign (₹), Service Mark symbol (℠),
plusminus character (±), bullet symbol, (•), various superscipt characters (⁰, ¹, ², ³, , ⁴, ⁵, ⁶, ⁷, ⁸, ⁹, ⁺, ⁻, ⁼), 
certain fractions (¼, ½, ¾) and certain Greek letters used in equations such as (Δ, Σ, δ, θ, π, ∞).

### 8-makedata_layernew.sh

*IT IS NOT REQUIRED TO RUN THIS SCRIPT AS THE OUTPUT FOLDERS ARE PROVIDED AS A SUBMODULE IN THE REPO.*
Use `git submodule update --init` to download the files (approx 900MB).

In order to ensure that existing characters in the eng.lstm-unicharset are adequately represented during
training, text is extracted from `tesseract-ocr/langdata_lstm/eng/eng.training_text` with at least 5 of
each character. This is concatenated with `tesseract-ocr/langdata/eng/eng.training_text` and additional
training texts so as to have at least 15 of each new character to be added. 
Additional fonts are used for rendering to ensure that too many characters are not dropped as unrenderable 
during text2image rendering . As in the earlier tutorials, same training text is rendered in Impact font 
as evaluation data.

### 9-layernew.sh

Run this script to cut-off and replace the top layer of network spec from eng.traineddata and
train using lstmf files generated using `langdata/eng/eng.layer.training_text` with about 100 fonts
for 50000 iterations. The script will take a while to run.

Here is an example image with its OCRed text using `tessdata_best/eng.traineddata` to compared
against the finetuned `eng_layer.traineddata`.

#### tessdata_best/eng.traineddata

```
United Forums ©2019
¥501.00 “The save happened on Monday.
eBay™ -- ADDED $75 2PX
superscripts,” three cubed 3°
(x-1)% + (y+1)* = 2° +322
Apr 6, 2020 - ¥9.51/kWh
Serialis*™ is a company.”
MOVIE® is at 90°F
number will be +5 kg.
§1.1 Paragraph is ‘quoted’
one fourth is written as %
I want % a pizza not 3 or more,
```
![alt text][logo]

[logo]: https://github.com/Shreeshrii/tess4training/raw/master/layernew.png "Sample Image"
#### FINETUNED eng_layer.traineddata (trained to error rate of ~ 0.5%)

```
United Forums ©2019
₹501.00 “The save happened on Monday.
eBay™ -- ADDED $75 2PX
superscripts,² three cubed 3³
(x-1)² + (y+1)³ = Z³ +3a²
Apr 6, 2020 - ₹9.51/kWh
Serialis℠ is a company.”
MOVIE® is at 90°F
number will be ±5 kg.
§1.1 Paragraph is ‘quoted
one fourth is written as ¼
] want ½ a pizza not ³¾ or more,
```




