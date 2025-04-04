#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "No hostname supplied"
  exit 1
fi

if [ -z "$2" ]; then
  echo "No target supplied"
  exit 1
fi

if [ -z "$3" ]; then
  echo "No keys supplied"
  exit 1
fi

nixos-anywhere -f ".#$1" --target-host "$2" --extra-files "$3"
