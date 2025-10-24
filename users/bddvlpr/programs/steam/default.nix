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
    { path = ".factorio"; }
    { path = ".local/share/Steam"; }
  ];
}
