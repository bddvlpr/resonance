{
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in
{
  home.packages = lib.mkIf isLinux [ pkgs.mangohud ];

  bowl.persist.entries = [
    { from = ".factorio"; }
    { from = ".local/share/Yellow\ Dog\ Man\ Studios"; }
    { from = ".cache/Yellow\ Dog\ Man\ Studios"; }
    { from = ".local/share/Steam"; }
  ];
}
