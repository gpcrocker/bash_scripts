#!/bin/bash

src="/Users/grahamcrocker/src"

for directory in $src/*/ ; do
    alias $(basename "$directory")="cd $directory"
done
