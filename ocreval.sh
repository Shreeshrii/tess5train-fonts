#!/bin/bash
# $1 - MODEL_NAME
# $2 - FAST_PATH_TRAINEDDATA

MODEL_NAME=$1
FAST_PATH=data/$MODEL_NAME/tessdata_fast
FAST_PATH_TRAINEDDATA=$2
REPORTS_PATH=data/${MODEL_NAME}/reports/${FAST_MODEL_NAME}
EVAL_LSTMF=data/${MODEL_NAME}/list.eval
EVAL_TIF=data/${MODEL_NAME}/list.tif.eval
EVAL_TXT=data/${MODEL_NAME}/list.txt.eval

for model in ${FAST_PATH_TRAINEDDATA} ; do
    FAST_MODEL_NAME=$(basename $model .traineddata)
    rm -rf ${REPORTS_PATH}
    mkdir -p ${REPORTS_PATH}
    combine_tessdata -l ${FAST_PATH}/${FAST_MODEL_NAME}.traineddata

	sed -e 's/lstmf/tif/' ${EVAL_LSTMF} > ${EVAL_TIF}
	sed -e 's/lstmf/gt.txt/' ${EVAL_LSTMF} > ${EVAL_TXT}

    while IFS= read -r file; do
       cat "$file" >> ${REPORTS_PATH}/GT.txt
    done < "${EVAL_TXT}"

        time -p tesseract \
         ${EVAL_TIF} \
         ${REPORTS_PATH}/OCR \
         -l ${FAST_MODEL_NAME} --tessdata-dir ${FAST_PATH} \
         -c page_separator=''

    java -cp ~/ocreval.jar eu.digitisation.Main \
        -gt ${REPORTS_PATH}/GT.txt -e UTF-8  \
        -ocr ${REPORTS_PATH}/OCR.txt -e UTF-8  \
        -o ${FAST_PATH}/${FAST_MODEL_NAME}.ocrevaluation.html

     accuracy ${REPORTS_PATH}/GT.txt ${REPORTS_PATH}/OCR.txt \
        > ${FAST_PATH}/${FAST_MODEL_NAME}.accuracy.txt

done
