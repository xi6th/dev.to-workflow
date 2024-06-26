#!/bin/bash

# hold my api keys
# source ~/dotfiles/.credencials

# for better readability
title=$1
tags=$3
# the content has to be json encoded 
content=$(cat "$2" | jq '.' --raw-input --slurp)

# write it to a tmp file for better debugging and also for using a file path in the curl call
tee /tmp/devtoArticle.md << END
{"article":{"title":"$title","body_markdown":$content,"published":false,"tags":[$tags]}}
END

curl -X POST -H "Content-Type: application/json" \
    -H "api-key: nJRmFn8RQUH2yPgM3MshbX2Y" \
    -d @/tmp/devtoArticle.md \
    https://dev.to/api/articles