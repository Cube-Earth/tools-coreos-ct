#!/bin/sh
function show_error
{
  echo "ERROR: $1"
  exit 1
}


if ! curl -I -X HEAD -s -f https://api.github.com/repos/$GITHUB_REPO/releases/tags/$GITHUB_RELEASE > /dev/null 2>&1
then
  echo "creating release $GITHUB_RELEASE ..."
  curl -X POST -T - -u "$GITHUB_EMAIL:$GITHUB_PWD" https://api.github.com/repos/$GITHUB_REPO/releases << EOF
{
  "tag_name": "$GITHUB_RELEASE",
  "target_commitish": "master",
  "name": "$GITHUB_RELEASE",
  "body": "Compiled config transpiler (ct) for Alpine",
  "draft": false,
  "prerelease": false
}
EOF
fi

UPLOAD=`curl -s https://api.github.com/repos/$GITHUB_REPO/releases/tags/$GITHUB_RELEASE | jq -r '.upload_url' | sed 's/{.*}$//'`

gzip -c /usr/bin/ct > /tmp/ct.gz
curl -X POST -T /tmp/ct.gz --header "Content-length: `stat -c \"%s\" /tmp/ct.gz`" --header "Content-type: application/gzip" -u "$GITHUB_EMAIL:$GITHUB_PWD" "$UPLOAD?name=ct.gz&label=ct.gz%20%28for%20Alpine%29"

