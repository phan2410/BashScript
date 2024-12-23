# Propagate windows environment variable
# Replace MY_VAR with correct name
export MY_VAR=$(cmd.exe /c echo %MY_VAR% | tr -d '\r')
