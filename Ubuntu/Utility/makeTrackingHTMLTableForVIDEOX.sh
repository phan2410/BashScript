#!/bin/bash

# How to use:
# bash makeTrackingHTMLTableForVIDEOX.sh parentFolderContainingVIDEOXXDataFolders TSDFolder OptionalPathToOutputFile
# If OptionalPathToOutputFile is not given, then output will be ./trackingTbl.html

outputHTMLTableFile=$3

if [ -z "$outputHTMLTableFile" ]
then
  outputHTMLTableFile="trackingTbl.html"
fi

printf "<table style=\"width:100%%\">\n" > $outputHTMLTableFile
printf "  <tr>\n" >> $outputHTMLTableFile
printf "    <th>ChunkFolder</th>\n" >> $outputHTMLTableFile
printf "    <th>SrcDataFolder</th>\n" >> $outputHTMLTableFile
printf "    <th>MovieCount</th>\n" >> $outputHTMLTableFile
printf "    <th>MovieSumSize</th>\n" >> $outputHTMLTableFile
printf "    <th>FrameCount</th>\n" >> $outputHTMLTableFile
printf "    <th>FrameSumSize</th>\n" >> $outputHTMLTableFile
printf "    <th>SelectedFrameCount</th>\n" >> $outputHTMLTableFile
printf "    <th>SubmissionFrameCount</th>\n" >> $outputHTMLTableFile
printf "    <th>TotalDistance</th>\n" >> $outputHTMLTableFile
printf "    <th>TakeInDistance</th>\n" >> $outputHTMLTableFile
printf "  </tr>\n" >> $outputHTMLTableFile 

for d in $(find $1 -maxdepth 1 -type d | grep -P "VIDEO\d+")
do
  dName=`basename $d`
  printf "\n==> $dName"
  for d1 in $(find $d -maxdepth 1 -type d | grep -P "\d{8}_first|\d{8}_second")
  do
    d1Name=`basename $d1`
    noMOV=`find $d1 -name '*.MOV' -print0 | xargs -0n1 basename | uniq -c | wc -l`
    sizeMOV=`du -ch $d1 | grep "total" | grep -o "[0-9]*[GMK]"`
    noFrame=`find $(echo "$2/04_movie_frames/$d1Name" | sed 's,//,/,g') -type f -name '*.jpeg' | wc -l`
    sizeFrame=`du -ch $(echo "$2/04_movie_frames/$d1Name" | sed 's,//,/,g') | grep "total" | grep -o "[0-9]*[GMK]"`
    noSelectedFrame=`find $(echo "$2/07_detect_by_eyes/$d1Name/$d1Name_input" | sed 's,//,/,g') -type f -name '*.jpeg' | wc -l`
    noSubmissionFrame=`find $(echo "$2/10_submission/$d1Name/frames" | sed 's,//,/,g') -type f -name '*.jpeg' | wc -l`
    log01File="$2/log_01_TSD_cascade_preprocess/$d1Name.log"
    totalKm=""
    if [ -f "$log01File" ]; then
      totalKm=`cat $log01File | grep -P "The distance is \d+\.\d+ km" | sed -e 's/ //g' -e 's/Thedistanceis//' -e 's/km.//'`
    fi
    log02File="$2/log_02_TSD_cascade_frame_processing/$d1Name.log"
    takenKm=""
    if [ -f "$log02File" ]; then
      takenKm=`cat $log02File | grep -P "The total distance hw excluded is \d+\.\d+ km" | sed -e 's/ //g' -e 's/Thetotaldistancehwexcludedis//' -e 's/km.//'`
    fi
    printf "\n\t$d1Name $noMOV $sizeMOV $noFrame $sizeFrame $noSelectedFrame $noSubmissionFrame $totalKm $takenKm"
    printf "  <tr>\n" >> $outputHTMLTableFile
    printf "    <td>$dName</td>\n" >> $outputHTMLTableFile
    printf "    <td>$d1Name</td>\n" >> $outputHTMLTableFile
    printf "    <td>$noMOV</td>\n" >> $outputHTMLTableFile
    printf "    <td>$sizeMOV</td>\n" >> $outputHTMLTableFile
    printf "    <td>$noFrame</td>\n" >> $outputHTMLTableFile
    printf "    <td>$sizeFrame</td>\n" >> $outputHTMLTableFile
    printf "    <td>$noSelectedFrame</td>\n" >> $outputHTMLTableFile
    printf "    <td>$noSubmissionFrame</td>\n" >> $outputHTMLTableFile
    printf "    <td>$totalKm</td>\n" >> $outputHTMLTableFile
    printf "    <td>$takenKm</td>\n" >> $outputHTMLTableFile
    printf "  </tr>\n" >> $outputHTMLTableFile    
  done
  
done 2>/dev/null

printf "</table>\n" >> $outputHTMLTableFile

printf "\n\n"

