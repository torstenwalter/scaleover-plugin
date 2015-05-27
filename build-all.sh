#!/bin/sh

GOOS=linux GOARCH=amd64 go build
LINUX64_SHA1=`cat scaleover-plugin | openssl sha1`
mkdir -p bin/linux64
mv scaleover-plugin bin/linux64

GOOS=darwin GOARCH=amd64 go build
OSX_SHA1=`cat scaleover-plugin | openssl sha1`
mkdir -p bin/osx
mv scaleover-plugin bin/osx

GOOS=windows GOARCH=amd64 go build
WIN64_SHA1=`cat scaleover-plugin.exe | openssl sha1`
mkdir -p bin/win64
mv scaleover-plugin.exe bin/win64

cat repo-index.yml |
sed "s/osx-sha1/$OSX_SHA1/" |
sed "s/win64-sha1/$WIN64_SHA1/" |
sed "s/linux64-sha1/$LINUX64_SHA1/" |
cat

go build
