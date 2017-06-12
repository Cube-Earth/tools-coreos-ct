#!/bin/sh
export GITHUB_EMAIL=`git config user.email`
read -sp "Password for $GITHUB_EMAIL: " GITHUB_PWD
export GITHUB_PWD
export GITHUB_REPO=`git config --get remote.origin.url | sed -E -e 's#\.git$##'  -e 's#^.*github.com/(.*)$#\1#'`
export GITHUB_RELEASE=v1.0

docker-compose run --rm main
