git clone "$1" \
&& cd "$1" \
&& REPO_NAME=$(basename "$1") \
&& echo "At $1, please create phan2410/$REPO_NAME IMMEDIATELY" \
&& git fetch \
&& for b in $(git branch -r | sed -e 's/origin\///' | awk '$0 ~ /^[^\>]+$/'); do git checkout $b && sleep 2.5 && git pull && sleep 3; done \
&& git remote set-url origin "https://phan2410:<token>@github.com/phan2410/$REPO_NAME" \
&& git push --all origin
