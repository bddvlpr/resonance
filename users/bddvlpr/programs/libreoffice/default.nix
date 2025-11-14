{
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in
{
  config = lib.mkIf isLinux {
    home.packages = [ pkgs.libreoffice ];

    bowl.persist.entries = [
      { path = ".config/libreoffice"; }
    ];
  };
}
