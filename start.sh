#!/bin/bash

# Avoid “Another git process seems to be running in this repository” error
rm -f /home/deno/git-repository/.git/index.lock

# If the repository has been set up
if [ -d "/home/deno/git-repository/.git" ]
then
  echo "Repository already set up. Building..."

  echo "Running reset.sh..."
  bash /home/deno/reset.sh

  echo "Running build-site.sh..."
  bash /home/deno/build-site.sh

  # Start the server
  echo "Starting the server..."
  cd /home/deno/git-repository && deno task file-server
else
  echo "Setting up repository and building..."

  echo "Running setup.sh..."
  bash /home/deno/setup.sh

  echo "Running setup-images-and-build.sh..."
  bash /home/deno/setup-images-and-build.sh

  # Start the server
  echo "Starting the server..."
  cd /home/deno/git-repository && deno task file-server
fi
