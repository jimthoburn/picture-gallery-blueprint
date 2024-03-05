#!/bin/bash

# Avoid “Another git process seems to be running in this repository” error
rm -f /home/deno/git-repository/.git/index.lock

# If the repository has been set up
if [ -d "/home/deno/git-repository/.git" ]
then
  echo "Repository already set up. Building..."
  bash /home/deno/reset.sh
  bash /home/deno/build-site.sh
else
  echo "Setting up repository and building..."
  bash /home/deno/setup.sh
  bash /home/deno/setup-images-and-build.sh
fi

# Hand off to the CMD
cd /home/deno/git-repository && deno task file-server
