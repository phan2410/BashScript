#!/bin/bash

cat pairs.csv | sed -e 's/.*,//' -e '1d' -e 's/\^M//' | sort > csvFrameList &&
dos2unix csvFrameList 1>/dev/null 2>&1 &&
ls frames | sort > frameList &&
git diff csvFrameList frameList

