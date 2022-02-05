#!/bin/bash

BASE=$1

cat $BASE.syl | while IFS="
" read target; do grep -F -m 5 "$target"  $BASE.txt ; done > tmp3.txt
sort -u tmp3.txt   > tmp
create_dictdata -i  tmp -d ./ -l $BASE-eval
shuf -o $BASE-eval.training_text < $BASE-eval.training_text
rm -rf tmp*

awk '{if (f==1) { r[$0] } else if (! ($0 in r)) { print $0 } } ' f=1 $BASE-eval.training_text f=2 $BASE.txt > tmp-X.txt

cat $BASE.syl | while IFS="
" read target; do grep -F -m 50 "$target"  tmp-X.txt ; done > tmp2.txt
awk '{if (f==1) { r[$0] } else if (! ($0 in r)) { print $0 } } ' f=1 tmp2.txt f=2 tmp-X.txt > $BASE-REMAIN.txt
sort -u tmp2.txt   > tmp4.txt
create_dictdata -i  tmp4.txt -d ./ -l $BASE-train
shuf -o $BASE-train.training_text <$BASE-train.training_text
rm -rf tmp*

python3 ../../count_chars.py $BASE-train.training_text | sort -n -r > $BASE-train.count_chars.txt

rm *bigram*
#rm *.wordlist
