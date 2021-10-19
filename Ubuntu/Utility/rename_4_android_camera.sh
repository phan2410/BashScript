ls -t -l --time-style="+%Y%m%d_%H%M%S" | tail -n +2 | awk '{split($7, file_name, "."); print "mv " $7 " " $6 "."  file_name[2]}' | eval $0
