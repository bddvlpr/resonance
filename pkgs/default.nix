{
  pkgs,
  lib,
  ...
}:
let
  inherit (builtins) readDir mapAttrs;
  inherit (pkgs) callPackage;
  inherit (lib.attrsets) filterAttrs;

  packages = filterAttrs (pkg: type: type == "directory") (readDir ./.);
in
mapAttrs (k: _: callPackage ./${k} { }) packages
