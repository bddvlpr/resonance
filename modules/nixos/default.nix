{ lib, ... }:
let
  inherit (builtins) readDir mapAttrs;
  inherit (lib.attrsets) filterAttrs;

  modules = filterAttrs (module: type: type == "directory") (readDir ./.);
in
mapAttrs (k: _: import ./${k}) modules
