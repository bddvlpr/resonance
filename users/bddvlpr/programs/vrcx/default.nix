{
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) optionals;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in
{
  home.packages = optionals isLinux [ pkgs.vrcx ];

  bowl.persist.entries = [
    { path = ".config/VRCX"; }
  ];
}
