#!/bin/bash

# Avoid “Another git process seems to be running in this repository” error
rm -f /home/deno/git-repository/.git/index.lock

# If the repository has been set up
if [ -d "/home/deno/git-repository/.git" ]
then
  echo "Repository already set up. Building..."

  # Run a script, without waiting for it to finish (since waiting for this step may cause the deploy to time out)
  # https://unix.stackexchange.com/questions/86247/what-does-ampersand-mean-at-the-end-of-a-shell-script-line#answer-86253
  bash /home/deno/reset-and-build.sh &
else
  echo "Setting up repository and building..."

  # Run a script, without waiting for it to finish (since waiting for this step may cause the deploy to time out)
  # https://unix.stackexchange.com/questions/86247/what-does-ampersand-mean-at-the-end-of-a-shell-script-line#answer-86253
  bash /home/deno/setup-and-build.sh &
fi

# Hand off to the CMD
exec "$@"
