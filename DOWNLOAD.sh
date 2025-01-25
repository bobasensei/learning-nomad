#!/bin/sh

if [ "$(uname -i)" == "x86_64" ]; then
  arch=amd64
else
  arch=arm64
fi

path="https://releases.hashicorp.com/nomad/1.9.5/nomad_1.9.5_linux_$arch.zip"

echo $path
