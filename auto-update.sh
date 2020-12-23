#!/usr/bin/bash
# prerequisites: curl grep sed git

cd Formula || exit 2
# assuming the first tag is the latest tag
TAG=$(curl -s -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/p4gefau1t/trojan-go/tags | grep -m 1 -oE 'v[0-9]+.[0-9]+.[0-9]+')
if grep -q "version \"${TAG#v}\"" trojan-go.rb; then
    exit 0
fi
DOWNLOAD_URL="https://github.com/p4gefau1t/trojan-go/releases/download/${TAG}/trojan-go-darwin-amd64.zip"
SHASUM=$(curl -sSL "$DOWNLOAD_URL" | sha256sum -b | cut -d' ' -f1)
sed -e "s#^  url.*#  url \"$DOWNLOAD_URL\"#" -e "s/^  version.*/  version \"${TAG#v}\"/" -e "s/^  sha256.*/  sha256 \"${SHASUM}\"/" -i trojan-go.rb
git config user.name github-actions
git config user.email github-actions@github.com
git commit -am "trojan-go ${TAG}"
git push
