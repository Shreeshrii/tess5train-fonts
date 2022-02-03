#!/bin/bash

text2image --find_fonts --text langdata/eng/eng.rupee.training_text --outputbase ./findfonts --fonts_dir /usr/share/fonts --min_coverage 1  |& grep raw | sed -e 's/ :.*/"/g'  | sed -e 's/^/"/' > findfonts.rupee.1.txt
