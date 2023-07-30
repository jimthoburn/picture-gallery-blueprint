#!/bin/bash

# Avoid “Another git process seems to be running in this repository” error
rm -f /home/deno/git-repository/.git/index.lock

# Link `/deno/site` folder to `/home/deno/git-repository`
if [ -d "/home/deno/git-repository/_site" ]; then
  rm -df /home/deno/site
  ln -s /home/deno/git-repository/_site /home/deno/site
fi

# Hand off to the CMD
exec "$@"
