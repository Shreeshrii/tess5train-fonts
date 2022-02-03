export

#TODO - Improve based on feedback in https://github.com/tesseract-ocr/tesstrain/pull/236/files

## Make sure that sort always uses the same sort order.
LC_ALL := C

SHELL := /bin/bash
LOCAL := $(PWD)/usr
PATH := $(LOCAL)/bin:$(PATH)

# Path to the .traineddata directory with traineddata suitable for training
# (for example from tesseract-ocr/tessdata_best). Default: $(LOCAL)/share/tessdata
TESSDATA =  $(LOCAL)/share/tessdata

# Name of the model to be built. Default: $(MODEL_NAME)
MODEL_NAME = foo

# Data directory for output files, proto model, start model, etc. Default: $(DATA_DIR)
DATA_DIR = data

# Output directory for generated files. Default: $(OUTPUT_DIR)
OUTPUT_DIR = $(DATA_DIR)/$(MODEL_NAME)

# Tesstrain Ground truth directory. Default: $(TESSTRAIN_TRUTH_DIR)
TESSTRAIN_TRUTH_DIR := $(DATA_DIR)/ground-truth/$(MODEL_NAME)-train

# Tesseval Ground truth directory. Default: $(TESSEVAL_TRUTH_DIR)
TESSEVAL_TRUTH_DIR := $(DATA_DIR)/ground-truth/$(MODEL_NAME)-eval

# Optional Wordlist file for Dictionary dawg. Default: $(WORDLIST_FILE)
WORDLIST_FILE := $(OUTPUT_DIR)/$(MODEL_NAME).wordlist

# Optional Numbers file for number patterns dawg. Default: $(NUMBERS_FILE)
NUMBERS_FILE := $(OUTPUT_DIR)/$(MODEL_NAME).numbers

# Optional Punc file for Punctuation dawg. Default: $(PUNC_FILE)
PUNC_FILE := $(OUTPUT_DIR)/$(MODEL_NAME).punc

# Name of the model to continue from. Default: '$(START_MODEL)'
START_MODEL = eng

LAST_CHECKPOINT = $(OUTPUT_DIR)/checkpoints/$(MODEL_NAME)_checkpoint

# Name of the proto model. Default: '$(PROTO_MODEL)'
PROTO_MODEL = $(OUTPUT_DIR)/$(MODEL_NAME)-proto.traineddata

# Name of the final trained model. Default: '$(TRAINED_MODEL)'
TRAINED_MODEL = $(DATA_DIR)/$(MODEL_NAME)-final.traineddata

# Name of the final trained integer model. Default: '$(TRAINED_INTEGER_MODEL)'
TRAINED_INTEGER_MODEL = $(DATA_DIR)/$(MODEL_NAME)-integer.traineddata

# Max iterations. Default: $(MAX_ITERATIONS)
MAX_ITERATIONS := 10000

# Debug Interval. Default:  $(DEBUG_INTERVAL)
DEBUG_INTERVAL := 0

# Learning rate. Default: $(LEARNING_RATE)
ifdef START_MODEL
LEARNING_RATE := 0.0001
else
LEARNING_RATE := 0.002
endif

# Network specification. Default: $(NET_SPEC)
NET_SPEC := [1,36,0,1 Ct3,3,16 Mp3,3 Lfys48 Lfx96 Lrx96 Lfx192 O1c\#\#\#]

# Setup for Finetune, Replace top layer of network
# 	NET_SPEC =--continue_from $(DATA_DIR)/$(START_MODEL)/$(START_MODEL).lstm --append_index 2 --net_spec '[Lfys48 Lfx96 Lrx96 Lfx192O1c1]'
ifeq ($(TRAIN_TYPE),FineTune)
	NET_SPEC =--continue_from $(DATA_DIR)/$(START_MODEL)/$(START_MODEL).lstm --old_traineddata $(TESSDATA)/$(START_MODEL).traineddata
	LEARNING_RATE := 0.0001
else
ifeq ($(TRAIN_TYPE),ReplaceLayer)
	NET_SPEC =--continue_from $(DATA_DIR)/$(START_MODEL)/$(START_MODEL).lstm --append_index 5 --net_spec '[Lfx192O1c1]'
	LEARNING_RATE := 0.0002
endif
endif

# Default Fonts Directory. Default: $(TESSTRAIN_FONTS_DIR)
TESSTRAIN_FONTS_DIR := /usr/share/fonts/

# Default Training Text. Default: $(TESSTRAIN_TEXT)
TESSTRAIN_TEXT := $(TESSTRAIN_TRUTH_DIR).training_text

# Default Evaluation Text. Default: $(TESSEVAL_TEXT)
TESSEVAL_TEXT := $(TESSEVAL_TRUTH_DIR).training_text

# Font for training. Default: $(TESSTRAIN_FONTS)
TESSTRAIN_FONTS =
# Font List for training. Default: $(TESSTRAIN_FONT_LIST)
ifdef TESSTRAIN_FONTS
TESSTRAIN_FONT_LIST =--fontlist $(TESSTRAIN_FONTS)
else
TESSTRAIN_FONT_LIST =
endif

# Font for evaluation. Default: $(TESSEVAL_FONTS)
TESSEVAL_FONTS =
# Font List for evaluation. Default: $(TESSEVAL_FONT_LIST)
ifdef TESSEVAL_FONTS
TESSEVAL_FONT_LIST =--fontlist $(TESSEVAL_FONTS)
else
TESSEVAL_FONT_LIST =
endif

# Default maximum number of pages from training text. Default: $(TESSTRAIN_MAX_PAGES)
TESSTRAIN_MAX_PAGES := 0

# Default maximum number of pages from evaluation text. Default: $(TESSEVAL_MAX_PAGES)
TESSEVAL_MAX_PAGES := 0

# Default Language Script for training. Default: $(TESSTRAIN_SCRIPT)
TESSTRAIN_SCRIPT := Latin

# Default Language for training. Default: $(TESSTRAIN_LANG)
TESSTRAIN_LANG := eng

# Page segmentation mode. Default: $(PSM)
PSM = 4

# Random seed for shuffling of the training data. Default: $(RANDOM_SEED)
RANDOM_SEED := 0

# Default Target Error Rate. Default: $(TARGET_ERROR_RATE)
TARGET_ERROR_RATE := 0.01

GENERATE_BOX_SCRIPT =generate_gt_from_box.py

# Directory for logs. Default: $(LOGS_DIR)
LOGS_DIR = $(DATA_DIR)/logs

# Directory for plot and tsv files for the model. Default: $(PLOT_DIR)
PLOT_DIR = $(OUTPUT_DIR)/plots

# Directory for evaluation reports for the model. Default: $(REPORT_DIR)
REPORT_DIR = $(OUTPUT_DIR)/reports

# Directory for Temporary files used in plotting. Default: $(TMP_DIR)
TMP_DIR = $(OUTPUT_DIR)/tmp

# Training log file. This should match logfile name from training. Default: $(MODEL_LOG)
MODEL_LOG = ${LOGS_DIR}/$(MODEL_NAME).LOG

# Maximum CER to display on y axis of plot. Default: $(Y_MAX_CER)
Y_MAX_CER = 2

# lstmeval BCER and filenames.  Default: $(LSTMEVAL_CER)
LSTMEVAL_CER = ${REPORT_DIR}/$(MODEL_NAME)-lstmeval.txt

# Java ocrevaluation CER and filenames (generated by ocreval.sh). Default: $(OCREVAL_CER)
OCREVAL_CER = ${REPORT_DIR}/$(MODEL_NAME)-ocreval.txt

# TSV file with header, iteration, checkpoint, eval and validation CER. Default: $(TSV_ALL_CER)
# Info only. Individual temporary tsv files are used for plotting.
TSV_ALL_CER = $(PLOT_DIR)/$(MODEL_NAME)-cer.tsv

# Temporary files.
TSV_100_ITERATIONS = $(TMP_DIR)/$(MODEL_NAME)-iteration.tsv
TSV_CHECKPOINT = $(TMP_DIR)/$(MODEL_NAME)-checkpoint.tsv
TSV_EVAL = $(TMP_DIR)/$(MODEL_NAME)-eval.tsv
TSV_SUB = $(TMP_DIR)/$(MODEL_NAME)-sub.tsv
TSV_LSTMEVAL = $(TMP_DIR)/$(MODEL_NAME)-lstmeval.tsv
TSV_OCREVAL = $(TMP_DIR)/$(MODEL_NAME)-ocreval.tsv
TMP_FAST_LOG = $(TMP_DIR)/$(MODEL_NAME)-lstmeval-fast.log
TMP_LSTMEVAL_LOG = $(TMP_DIR)/$(MODEL_NAME)-lstmeval.log

# BEGIN-EVAL makefile-parser --make-help Makefile

help:
	@echo ""
	@echo "  Targets"
	@echo ""
	@echo "    lists                  Create lists of lstmf filenames for training and eval"
	@echo "    training               Start training"
	@echo "    traineddata            Create best and fast .traineddata files from each .checkpoint file"
	@echo "    proto-model            Build the proto model"
	@echo "    clean-log              Clean log file"
	@echo "    clean-groundtruth      Clean generated groundtruth files"
	@echo "    clean-output           Clean generated output files"
	@echo "    clean                  Clean all generated files"
	@echo ""
	@echo "  Variables"
	@echo ""
	@echo "    TESSDATA              Path to the .traineddata directory with traineddata suitable for training "
	@echo "                          (for example from tesseract-ocr/tessdata_best). Default: $(LOCAL)/share/tessdata"
	@echo "    MODEL_NAME            Name of the model to be built. Default: $(MODEL_NAME)"
	@echo "    DATA_DIR              Data directory for output files, proto model, start model, etc. Default: $(DATA_DIR)"

	@echo "    OUTPUT_DIR            Output directory for generated files. Default: $(OUTPUT_DIR)"
	@echo "    TESSTRAIN_TRUTH_DIR   Training Ground truth directory. Default: $(TESSTRAIN_TRUTH_DIR)"
	@echo "    TESSEVAL_TRUTH_DIR    Evaluation Ground truth directory. Default: $(TESSEVAL_TRUTH_DIR)"
	@echo "    WORDLIST_FILE         Optional Wordlist file for Dictionary dawg. Default: $(WORDLIST_FILE)"
	@echo "    NUMBERS_FILE          Optional Numbers file for number patterns dawg. Default: $(NUMBERS_FILE)"
	@echo "    PUNC_FILE             Optional Punc file for Punctuation dawg. Default: $(PUNC_FILE)"
	@echo "    START_MODEL           Name of the model to continue from. Default: '$(START_MODEL)'"
	@echo "    PROTO_MODEL           Name of the proto model. Default: '$(PROTO_MODEL)'"

	@echo "    MAX_ITERATIONS        Max iterations. Default: $(MAX_ITERATIONS)"
	@echo "    DEBUG_INTERVAL        Debug Interval. Default:  $(DEBUG_INTERVAL)"
	@echo "    LEARNING_RATE         Learning rate. Default: $(LEARNING_RATE)"
	@echo "    TARGET_ERROR_RATE     Target Error Rate. Default: $(TARGET_ERROR_RATE)"
	@echo "    TESSTRAIN_FONTS_DIR   Fonts Directory. Default: $(TESSTRAIN_FONTS_DIR)"
	@echo "    TESSTRAIN_TEXT        Training Text. Default: $(TESSTRAIN_TEXT)"
	@echo "    TESSEVAL_TEXT         Evaluation Text. Default: $(TESSEVAL_TEXT)"
	@echo "    TESSTRAIN_FONTS       Font for training. Default: $(TESSTRAIN_FONTS)"
	@echo "    TESSTRAIN_MAX_PAGES   Maximum number of pages from training text. Default: $(TESSTRAIN_MAX_PAGES)"
	@echo "    TESSEVAL_MAX_PAGES    Maximum number of pages from evaluation text. Default: $(TESSTRAIN_MAX_PAGES)"
	@echo "    TESSTRAIN_LANG        Language code of existing language for creating PROTO_MODEL. "
	@echo "                          (It can be the same as START_MODEL for fine-tuning). Default: $(TESSTRAIN_LANG)"
	@echo "    TESSTRAIN_SCRIPT      Language Script (eg. Latin for eng, Bengali for ben). Default: $(TESSTRAIN_SCRIPT)"
	@echo "    TRAIN_TYPE            Training Type - FineTune, ReplaceLayer or blank (from scratch). Default: '$(TRAIN_TYPE)'"

# END-EVAL

.PRECIOUS: $(OUTPUT_DIR)/checkpoints/$(MODEL_NAME)*_checkpoint

.PHONY:

all: clean help proto_model lists groundtruth training traineddata

# plotting

plotCER: $(OCREVAL_CER) $(LSTMEVAL_CER) $(TSV_ALL_CER)

# Make TSV with CER at every 100 iterations.
$(TSV_100_ITERATIONS):
	@echo "Name	CheckpointCER	LearningIteration	TrainingIteration	EvalCER	IterationCER	SubtrainerCER" > "$@"
	@grep 'At iteration' $(MODEL_LOG) \
		| sed -e '/^Sub/d' \
		| sed -e '/^Update/d' \
		| sed -e '/^ New worst BCER/d' \
		| sed -e 's/At iteration \([0-9]*\)\/\([0-9]*\)\/.*BCER train=/\t\t\1\t\2\t\t/' \
		| sed -e 's/%, BWER.*/\t/' >>  "$@"

# Make TSV with Checkpoint CER.
$(TSV_CHECKPOINT):
	@echo "Name	CheckpointCER	LearningIteration	TrainingIteration	EvalCER	IterationCER	SubtrainerCER" > "$@"
	@grep 'best model' $(MODEL_LOG) \
		| sed -e 's/^.*\///' \
		| sed -e 's/\.checkpoint.*$$/\t\t\t/' \
		| sed -e 's/_/\t/g' >>  "$@"

# Make TSV with Eval CER.
$(TSV_EVAL):
	@echo "Name	CheckpointCER	LearningIteration	TrainingIteration	EvalCER	IterationCER	SubtrainerCER" > "$@"
	@grep 'BCER eval' $(MODEL_LOG) \
		| sed -e 's/^.*[0-9]At iteration //' \
		| sed -e 's/,.* BCER eval=/\t\t/'  \
		| sed -e 's/, BWER.*$$/\t\t/' \
		| sed -e 's/^/\t\t/' >>  "$@"

# Make TSV with Subtrainer CER.
$(TSV_SUB):
	@echo "Name	CheckpointCER	LearningIteration	TrainingIteration	EvalCER	IterationCER	SubtrainerCER" > "$@"
	@grep '^UpdateSubtrainer' $(MODEL_LOG) \
		| sed -e 's/^.*At iteration \([0-9]*\)\/\([0-9]*\)\/.*BCER train=/\t\t\1\t\2\t\t\t/' \
		| sed -e 's/%, BWER.*//' >>  "$@"

# Make TSV with lstmeval CER.
$(TSV_LSTMEVAL):
	@echo "Name	CheckpointCER	LearningIteration	TrainingIteration	EvalCER	IterationCER	SubtrainerCER" > "$@"
	@grep 'BCER eval' $(LSTMEVAL_CER) \
		| sed -e 's/^BCER eval=\(.*\), BWER.*\t.*_\(.*\)_\(.*\)\.eval.log/\t\t\2\t\3\t\1\t\t/' >>  "$@"

# Make TSV with ocreval CER.
$(TSV_OCREVAL):
	@echo "Name	CheckpointCER	LearningIteration	TrainingIteration	EvalCER	IterationCER	SubtrainerCER" > "$@"
	@grep 'CER' $(OCREVAL_CER) \
		| sed -e 's/^.*_\(.*\)_\(.*\)\.ocreval.*><td>\(.*\)<.*/\t\t\1\t\2\t\3\t\t/' >>  "$@"

# Combine TSV files with all required CER values, generated from training log and validation logs. Plot.
$(TSV_ALL_CER): $(TSV_100_ITERATIONS) $(TSV_CHECKPOINT) $(TSV_EVAL) $(TSV_SUB) $(TSV_LSTMEVAL) $(TSV_OCREVAL)
	@cat $(TSV_100_ITERATIONS) $(TSV_CHECKPOINT) $(TSV_EVAL) $(TSV_SUB) $(TSV_LSTMEVAL) $(TSV_OCREVAL) > "$@"
	python plot_LOG.py $(MODEL_NAME),$(Y_MAX_CER),$(TSV_100_ITERATIONS),$(TSV_CHECKPOINT),$(TSV_EVAL),$(TSV_SUB)
	python plot_cer.py $(MODEL_NAME),$(Y_MAX_CER),$(TSV_100_ITERATIONS),$(TSV_CHECKPOINT),$(TSV_EVAL),$(TSV_SUB),$(TSV_LSTMEVAL),$(TSV_OCREVAL)
	
# lstmeval and ocreval

evalCER: $(LSTMEVAL_CER) $(TMP_FAST_LOG) $(FAST_LSTMEVAL_FILES) $(OCREVAL_CER) $(FAST_OCREVAL_FILES)

# Build fast traineddata file list with CER in range [0-1].[0-9].
FAST_DATA_FILES := $(wildcard $(OUTPUT_DIR)/tessdata_fast/$(MODEL_NAME)_[0]\.[0-9]*.traineddata)

# Build lstmeval files list based on above traineddata list.
FAST_LSTMEVAL_FILES := $(subst tessdata_fast,tessdata_fast,$(patsubst %.traineddata,%.eval.log,$(FAST_DATA_FILES)))

$(FAST_LSTMEVAL_FILES): %.eval.log: %.traineddata
	time -p lstmeval  \
		--verbosity=0 \
		--model $< \
		--eval_listfile $(OUTPUT_DIR)/list.eval 2>&1 | grep "^BCER eval" > $@

# Concatenate all lstmeval files along with their filenames.
$(TMP_FAST_LOG): $(FAST_LSTMEVAL_FILES)
	@for i in $^; do \
		echo Filename : "$$i";echo;cat "$$i"; \
	done > $@

$(LSTMEVAL_CER): $(TMP_FAST_LOG)
	@grep -E "eval.log$$|BCER" $(TMP_FAST_LOG) > $(TMP_LSTMEVAL_LOG)
	sed -i '/^Filename/N;s/\n/ /' $(TMP_LSTMEVAL_LOG)
	sort -n -r -o $(TMP_LSTMEVAL_LOG) $(TMP_LSTMEVAL_LOG)
	sed -e 's/\(Filename.*.log\).*\(BCER.*\)/\2 \t \1/g' $(TMP_LSTMEVAL_LOG) > $@

# OCReval files list based on fast traineddata list.
FAST_OCREVAL_FILES := $(subst tessdata_fast,tessdata_fast,$(patsubst %.traineddata,%.ocrevaluation.html,$(FAST_DATA_FILES)))

$(FAST_OCREVAL_FILES):  %.ocrevaluation.html: %.traineddata
	bash ocreval.sh $(MODEL_NAME) $<

$(OCREVAL_CER): $(FAST_OCREVAL_FILES)
	grep '<td>CER</td><td>' $(OUTPUT_DIR)/tessdata_fast/$(MODEL_NAME)*.ocrevaluation.html > $(OCREVAL_CER)
	sort -n -r -o $(OCREVAL_CER) $(OCREVAL_CER)

# Rename checkpoints with one/two decimal digits to 3 decimal digts for correct sorting later.
fixcheckpoints:
	@mkdir -p $(PLOT_DIR)
	@mkdir -p $(REPORT_DIR)
	@mkdir -p $(TMP_DIR)
	@find $(OUTPUT_DIR)/checkpoints/ -regex ^.*$(MODEL_NAME)_[0-9]\.[0-9]_.*_.*.checkpoint -exec rename -v 's/(.[0-9])_/$${1}00_/' {} \;
	@find $(OUTPUT_DIR)/checkpoints/ -regex ^.*$(MODEL_NAME)_[0-9]*\.[0-9][0-9]_.*_.*.checkpoint -exec rename -v 's/(.[0-9][0-9])_/$${1}0_/' {} \;

CHECKPOINT_FILES := $(sort $(wildcard $(OUTPUT_DIR)/checkpoints/$(MODEL_NAME)*.checkpoint))

# Create best and fast .traineddata files from each .checkpoint file
traineddata: fixcheckpoints $(OUTPUT_DIR)/tessdata_best $(OUTPUT_DIR)/tessdata_fast

traineddata: $(subst checkpoints,tessdata_best,$(patsubst %.checkpoint,%.traineddata,$(CHECKPOINT_FILES)))
traineddata: $(subst checkpoints,tessdata_fast,$(patsubst %.checkpoint,%.traineddata,$(CHECKPOINT_FILES)))
$(OUTPUT_DIR)/tessdata_best $(OUTPUT_DIR)/tessdata_fast:
	mkdir $@
$(OUTPUT_DIR)/tessdata_best/%.traineddata: $(OUTPUT_DIR)/checkpoints/%.checkpoint
	lstmtraining \
          --stop_training \
          --continue_from $< \
          --traineddata $(PROTO_MODEL) \
          --model_output $@
$(OUTPUT_DIR)/tessdata_fast/%.traineddata: $(OUTPUT_DIR)/checkpoints/%.checkpoint
	lstmtraining \
          --stop_training \
          --continue_from $< \
          --traineddata $(PROTO_MODEL) \
          --convert_to_int \
          --model_output $@

# Do training
training: $(TRAINED_MODEL) $(TRAINED_INTEGER_MODEL)

$(TRAINED_INTEGER_MODEL): $(LAST_CHECKPOINT)
	lstmtraining \
	--stop_training \
	--continue_from $(LAST_CHECKPOINT) \
	--traineddata $(PROTO_MODEL) \
	--convert_to_int \
	--model_output $@
	
$(TRAINED_MODEL): $(LAST_CHECKPOINT)
	lstmtraining \
	--stop_training \
	--continue_from $(LAST_CHECKPOINT) \
	--traineddata $(PROTO_MODEL) \
	--model_output $@

$(LAST_CHECKPOINT):  $(ALL_GT) proto_model lists
	@mkdir -p $(OUTPUT_DIR)/checkpoints
	lstmtraining \
	  $(NET_SPEC) \
	  --traineddata $(PROTO_MODEL) \
	  --train_listfile $(OUTPUT_DIR)/list.train \
	  --eval_listfile $(OUTPUT_DIR)/list.eval \
	  --max_iterations $(MAX_ITERATIONS) \
	  --debug_interval $(DEBUG_INTERVAL) \
	  --learning_rate $(LEARNING_RATE) \
	  --target_error_rate $(TARGET_ERROR_RATE) \
	  --model_output $(OUTPUT_DIR)/checkpoints/$(MODEL_NAME) \
	  > $(MODEL_LOG)  2>&1

proto_model: $(PROTO_MODEL)

# Create lists of lstmf filenames for training and eval
lists: $(OUTPUT_DIR)/list.train $(OUTPUT_DIR)/list.eval

$(OUTPUT_DIR)/list.train $(PROTO_MODEL): $(OUTPUT_DIR)/list.eval
	python3 ./tesstrain.py \
	 --fonts_dir $(TESSTRAIN_FONTS_DIR) \
	 $(TESSTRAIN_FONT_LIST) \
	 --maxpages $(TESSTRAIN_MAX_PAGES) \
	 --lang $(TESSTRAIN_LANG) \
	 --langdata_dir $(DATA_DIR) \
	 --training_text $(TESSTRAIN_TEXT) \
	 --tessdata_dir $(TESSDATA) \
	 --linedata_only --noextract_font_properties \
	 --exposures "0" \
	 --save_box_tiff \
	 --output_dir $(TESSTRAIN_TRUTH_DIR)
	@mkdir -p $(OUTPUT_DIR)
	mv -v $(TESSTRAIN_TRUTH_DIR)/$(TESSTRAIN_LANG).training_files.txt $(OUTPUT_DIR)/list.train
	sed -i -e '$$a\' $(OUTPUT_DIR)/list.train
	@echo "" >> $(OUTPUT_DIR)/list.train
	mv -v $(TESSTRAIN_TRUTH_DIR)/$(TESSTRAIN_LANG)/$(TESSTRAIN_LANG).* $(OUTPUT_DIR)/
	rename "s/$(TESSTRAIN_LANG)\./$(MODEL_NAME)-train\./g" $(OUTPUT_DIR)/*.*
	cp -v $(OUTPUT_DIR)/$(MODEL_NAME)-train.traineddata $(PROTO_MODEL)
	combine_tessdata -dl $(PROTO_MODEL)
	@rm -rf -v $(TESSTRAIN_TRUTH_DIR)/$(TESSTRAIN_LANG)
	bash box2gt.sh $(TESSTRAIN_TRUTH_DIR)

$(OUTPUT_DIR)/list.eval: $(DATA_DIR)/$(TESSTRAIN_SCRIPT).unicharset $(DATA_DIR)/$(START_MODEL)/$(START_MODEL).lstm
	mkdir -p $(OUTPUT_DIR)

	python3 ./tesstrain.py \
	 --fonts_dir $(TESSTRAIN_FONTS_DIR) \
	 $(TESSEVAL_FONT_LIST) \
	 --maxpages $(TESSEVAL_MAX_PAGES) \
	 --lang $(TESSTRAIN_LANG) \
	 --langdata_dir $(DATA_DIR) \
	 --training_text $(TESSEVAL_TEXT) \
	 --tessdata_dir $(TESSDATA) \
	 --linedata_only --noextract_font_properties \
	 --exposures "0" \
	 --save_box_tiff \
	 --output_dir $(TESSEVAL_TRUTH_DIR)

	mv -v $(TESSEVAL_TRUTH_DIR)/$(TESSTRAIN_LANG).training_files.txt $(OUTPUT_DIR)/list.eval
	sed -i -e '$$a\' $(OUTPUT_DIR)/list.eval
	mv -v $(TESSEVAL_TRUTH_DIR)/$(TESSTRAIN_LANG)/$(TESSTRAIN_LANG).* $(OUTPUT_DIR)/
	rename "s/$(TESSTRAIN_LANG)\./$(MODEL_NAME)-eval\./g" $(OUTPUT_DIR)/*.*
	@rm -rf -v $(TESSEVAL_TRUTH_DIR)/$(TESSTRAIN_LANG)
	bash box2gt.sh $(TESSEVAL_TRUTH_DIR) 

# Setup training data
$(DATA_DIR)/$(START_MODEL)/$(START_MODEL).lstm: $(DATA_DIR)/$(START_MODEL)/$(START_MODEL).punc $(TESSDATA)/eng.traineddata
	@mkdir -p $(DATA_DIR)/$(START_MODEL)
	combine_tessdata -e $(TESSDATA)/$(START_MODEL).traineddata  $(DATA_DIR)/$(START_MODEL)/$(START_MODEL).lstm

$(DATA_DIR)/$(START_MODEL)/$(START_MODEL).punc: $(DATA_DIR)/$(START_MODEL)/$(START_MODEL).numbers
	@mkdir -p $(DATA_DIR)/$(START_MODEL)
	wget -O $@ 'https://github.com/tesseract-ocr/langdata_lstm/raw/main/eng/eng.punc'

$(DATA_DIR)/$(START_MODEL)/$(START_MODEL).numbers: $(TESSDATA)/$(START_MODEL).traineddata
	@mkdir -p $(DATA_DIR)/$(START_MODEL)
	wget -O $@ 'https://github.com/tesseract-ocr/langdata_lstm/raw/main/eng/eng.numbers'

$(TESSDATA)/$(START_MODEL).traineddata:
	wget -O $@ 'https://github.com/tesseract-ocr/tessdata_best/raw/main/$(START_MODEL).traineddata'

$(TESSDATA)/eng.traineddata:
	wget -O $@ 'https://github.com/tesseract-ocr/tessdata_best/raw/main/eng.traineddata'

$(DATA_DIR)/$(TESSTRAIN_SCRIPT).unicharset: $(DATA_DIR)/Latin.unicharset $(DATA_DIR)/radical-stroke.txt
	wget -O $@ 'https://github.com/tesseract-ocr/langdata_lstm/raw/main/$(TESSTRAIN_SCRIPT).unicharset'

$(DATA_DIR)/Latin.unicharset:
	wget -O $@ 'https://github.com/tesseract-ocr/langdata_lstm/raw/main/Latin.unicharset'

$(DATA_DIR)/radical-stroke.txt:
	@mkdir -p $(DATA_DIR)
	wget -O$@ 'https://github.com/tesseract-ocr/langdata_lstm/raw/main/radical-stroke.txt'
	wget -O lstm.train 'https://github.com/tesseract-ocr/tessconfigs/raw/main/configs/lstm.train'
	cp -v lstm.train $(TESSDATA)/

# Clean generated output files

clean-groundtruth:
	@rm -rf $(TESSTRAIN_TRUTH_DIR) $(TESSEVAL_TRUTH_DIR) || true

clean-checkpoints:
	@rm -rf $(OUTPUT_DIR)/checkpoints $(OUTPUT_DIR)/tessdata_best $(OUTPUT_DIR)/tessdata_fast || true

clean-traineddata:
	@rm -rf $(OUTPUT_DIR)/tessdata_best $(OUTPUT_DIR)/tessdata_fast || true

clean-post:
	@rm -rf $(TMP_DIR) $(PLOT_DIR) $(REPORT_DIR) || true
	@mkdir -p $(PLOT_DIR)
	@mkdir -p $(REPORT_DIR)
	@mkdir -p $(TMP_DIR)

clean-output:
	@rm -rf $(OUTPUT_DIR) || true
	@rm $(TRAINED_MODEL) || true
	@rm $(MODEL_LOG) || true

clean: clean-output
