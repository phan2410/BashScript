#!/bin/bash
# How to use:
# createQGISDifferenceBatchProcessJson $path_to_02_all_travel_route_info_folder $path_to_nikko_kokudo_kendo_kml_file $path_to_tmp_shp_folder $path_to_output_json_file
# after using this script, scrolling up to see correspondent output files for difference layers in reversing order

tmpShpFolder=$3
outputJsonFile=$4

NikkoDBExcludeKml=`realpath $2`

if [ -z "$outputJsonFile" ]
then
  outputJsonFile="QGISDifferenceBatchProcessScript.json"
fi

if [ -z "$tmpShpFolder" ]
then
  tmpShpFolder="./tmpSHP"
fi

mkdir -p $tmpShpFolder
rm -rf $tmpShpFolder/*.*

tmpShpFolder=`realpath $tmpShpFolder`

printf "\n\n==========\n\n"

printf "[" > $outputJsonFile

prefixStr="\n  {\n    \"OUTPUTS\": {\n      \"OUTPUT\": \""

for kmlFile in $(find `realpath $1` -name "*_point.kml" | sort)
do
  srcDataFolderName=`basename -s _point.kml $kmlFile`
  printf "\t`pwd`/outputCSV/$srcDataFolderName%c_diff.csv\n"
  printf "$prefixStr" >> $outputJsonFile
  printf "$tmpShpFolder/$srcDataFolderName.shp" >> $outputJsonFile
  printf "\"\n    },\n    \"PARAMETERS\": {\n      \"INPUT\": \"\\\\\"" >> $outputJsonFile
  printf "$kmlFile" >> $outputJsonFile
  printf "\\\\\"\",\n      \"IGNORE_INVALID\": \"False\", \"OVERLAY\": \"\\\\\"" >> $outputJsonFile
  printf "$NikkoDBExcludeKml" >> $outputJsonFile
  printf "\\\\\"\"\n    }\n  }" >> $outputJsonFile
  if [ "$prefixStr" != ",\n  {\n    \"OUTPUTS\": {\n      \"OUTPUT\": \"" ]
  then
    prefixStr=",\n  {\n    \"OUTPUTS\": {\n      \"OUTPUT\": \""
  fi
done

printf "\n]" >> $outputJsonFile

printf "\n==========\n\n"

cat $outputJsonFile
printf "\n\n"
