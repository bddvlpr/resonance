{
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in
{
  home.packages = lib.optionals isLinux [ pkgs.vrcx ];

  bowl.persist.entries = [
    { path = ".config/VRCX"; }
  ];
}
