#!/bin/bash
	echo "creating gt from box files for " $1
	find $1 -name '*.box' -exec sh -c 'python /home/ubuntu/tesstrain-fonts/generate_gt_from_box.py -b "$0" -t "${0%.box}.gt.txt"' {} \;
    find $1 -name '*.gt.txt' -exec touch -d "4 hours ago" {} +
    find $1 -name '*.tif' -exec touch -d "3 hours ago" {} +
    find $1 -name '*.box' -exec touch -d "2 hours ago" {} +
    find $1 -name '*.lstmf' -exec touch -d "1 hours ago" {} +

