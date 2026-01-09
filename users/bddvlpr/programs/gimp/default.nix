{ pkgs, lib, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in
{
  config = lib.mkIf isLinux {
    home.packages = [ pkgs.gimp-with-plugins ];

    bowl.persist.entries = [
      { from = ".config/GIMP"; }
      { from = ".cache/gimp"; }
    ];
  };
}
