#!/bin/bash

# How to use:
# bash mvIntoVIDEOX.sh parentFolderContainingVIDEOXXDataFolders workingFolder

patternFolder=`realpath $1`
workingFolder=`realpath $2`

for d in $(find $patternFolder -maxdepth 1 -type d | grep -P "VIDEO\d+")
do
    dName=`basename $d`
    for d1 in $(find $d -maxdepth 1 -type d | grep -P "\d{8}_first|\d{8}_second")
    do
	d1Name=`basename $d1`
	if ls $workingFolder/$d1Name* 1>/dev/null 2>&1; then
	    mkdir -p $workingFolder/$dName
	    mv -v $workingFolder/$d1Name* $workingFolder/$dName
	fi
    done
done
