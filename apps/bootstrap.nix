{
  pkgs,
  lib,
  inputs',
  ...
}: let
  nixos-anywhere = lib.getExe' inputs'.nixos-anywhere.packages.nixos-anywhere "nixos-anywhere";
in
  pkgs.writeShellScriptBin "bootstrap" ''
    if [ -z "$1" ]; then
      echo "no hostname supplied"
      exit 1
    fi

    if [ -z "$2" ]; then
      echo "no target supplied"
      exit 1
    fi

    if [ -z "$3" ]; then
      echo "no keys supplied"
      exit 1
    fi

    ${nixos-anywhere} -f ".#$1" --target-host "$2" --extra-files "$3"
  ''
