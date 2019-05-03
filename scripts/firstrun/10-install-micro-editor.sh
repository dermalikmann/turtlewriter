#!/usr/bin/env bash

# Partly from https://getmic.ro/

function githubLatestTag {
    finalUrl=$(curl "https://github.com/$1/releases/latest" -sLI -o /dev/null -w '%{url_effective}')
    echo "${finalUrl##*v}"
}


TAG=$(githubLatestTag zyedidia/micro)
curl -sL "https://github.com/zyedidia/micro/releases/download/v$TAG/micro-$TAG-linux-arm.tar.gz" | tar xzfv - "micro-$TAG/micro"

mv "micro-$TAG/micro" /usr/local/bin/micro
rm -rf micro.tar.gz "micro-$TAG"
