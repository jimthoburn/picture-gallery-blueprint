#!/bin/bash

# Make this script fail if any of the following steps fail
# https://stackoverflow.com/questions/821396/aborting-a-shell-script-if-any-command-returns-a-non-zero-value
set -Eeuo pipefail

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Starting setup"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "cd to /home/deno"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

cd /home/deno

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Configure Git"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

git config --global user.email $GITHUB_USER_EMAIL
git config --global user.name "$GITHUB_USER_NAME"
# https://stackoverflow.com/questions/73485958/how-to-correct-git-reporting-detected-dubious-ownership-in-repository-withou
git config --global --add safe.directory /home/deno/git-repository
git lfs install

cp /etc/secrets/id_ed25519 /home/deno/.ssh/id_ed25519
cp /etc/secrets/id_ed25519.pub /home/deno/.ssh/id_ed25519.pub
cp /etc/secrets/known_hosts /home/deno/.ssh/known_hosts

# https://unix.stackexchange.com/questions/31947/how-to-add-a-newline-to-the-end-of-a-file
sed -i -e '$a\' /home/deno/.ssh/id_ed25519
sed -i -e '$a\' /home/deno/.ssh/id_ed25519.pub
sed -i -e '$a\' /home/deno/.ssh/known_hosts

chmod 600 /home/deno/.ssh/id_ed25519
chmod 600 /home/deno/.ssh/id_ed25519.pub
chmod 600 /home/deno/.ssh/known_hosts

eval "$(ssh-agent -s)"

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Checkout repository for site"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

# https://stackoverflow.com/questions/42019529/how-to-clone-pull-a-git-repository-ignoring-lfs
GIT_LFS_SKIP_SMUDGE=1 \
  git clone \
    git@github.com:$GITHUB_REPOSITORY \
    /home/deno/git-repository

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "cd to /home/deno/git-repository"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

cd /home/deno/git-repository

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Check git status"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

git status

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Switch to branch main"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

git switch main

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Get LFS files"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

# https://github.com/git-lfs/git-lfs/issues/325

# Fetch a few times, in case the initial fetch is incomplete
git lfs fetch
git lfs fetch
git lfs fetch

git lfs pull

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Check git status"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

git status

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Check disk size"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

df -h

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Build site"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

cd /home/deno/git-repository && deno task build

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Link /deno/site folder to /deno/git-repository"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

if [ -d "/home/deno/git-repository/_site" ]; then
  rm -df /home/deno/site
  ln -s /home/deno/git-repository/_site /home/deno/site
fi

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Finished setup"
echo "- - - - - - - - - - - - - - - - - - - - - - -"
