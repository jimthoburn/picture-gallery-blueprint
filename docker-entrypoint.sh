#!/bin/bash

# Avoid “Another git process seems to be running in this repository” error
rm -f /home/deno/git-repository/.git/index.lock

# If the folder for the repository exists
if [ -d "/home/deno/git-repository" ]; then
  bash /usr/local/bin/update.sh
else
  bash /usr/local/bin/setup.sh
fi

# Hand off to the CMD
exec "$@"
