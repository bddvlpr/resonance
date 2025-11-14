{ pkgs, lib, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in
{
  config = lib.mkIf isLinux {
    home.packages = [ pkgs.gimp-with-plugins ];

    bowl.persist.entries = [
      { path = ".config/GIMP"; }
      { path = ".cache/gimp"; }
    ];
  };
}
