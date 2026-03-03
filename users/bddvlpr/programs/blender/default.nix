{ lib, pkgs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in
{
  config = lib.mkIf isLinux {
    home.packages = [
      (pkgs.blender.override { cudaSupport = true; })
    ];

    bowl.persist.entries = [
      { from = ".config/blender"; }
    ];
  };
}
