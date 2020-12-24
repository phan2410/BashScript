#!/bin/bash

exec_command=$(basename -- "$0")
if [ "$exec_command" != "source" ]; then
    printf "Please run:\n\tsource $0\n" >&2
    exit 1
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/fan/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/fan/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/fan/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/fan/miniconda3/bin:$PATH"
    fi
fi	
unset __conda_setup
# <<< conda initialize <<<

conda activate test
