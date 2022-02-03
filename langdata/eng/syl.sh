#!/bin/bash

cat syl.txt | while IFS="
" read target; do grep -F -m 2 "$target"  ALL.txt ; done > tmp3.txt
sort -u tmp3.txt   > tmp
create_dictdata -i  tmp -d ./ -l englayer-eval
shuf -o englayer-eval.training_text < englayer-eval.training_text
rm -rf tmp*

awk '{if (f==1) { r[$0] } else if (! ($0 in r)) { print $0 } } ' f=1 englayer-eval.training_text f=2 ALL.txt > tmp-X.txt

cat syl.txt | while IFS="
" read target; do grep -F -m 500 "$target"  tmp-X.txt ; done > tmp2.txt
awk '{if (f==1) { r[$0] } else if (! ($0 in r)) { print $0 } } ' f=1 tmp2.txt f=2 tmp-X.txt > REMAIN.txt
sort -u tmp2.txt   > tmp4.txt
create_dictdata -i  tmp4.txt -d ./ -l englayer-train
shuf -o englayer-train.training_text <englayer-train.training_text
rm -rf tmp*

python3 ../../count_chars.py englayer-train.training_text | sort -n -r > englayer-train.count_chars.txt

rm *bigram*
#rm *.wordlist
