{
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in
{
  config = lib.mkIf isLinux {
    services.gnome-keyring.enable = true;

    home.packages = [ pkgs.gcr ];

    bowl.persist.entries = [
      { path = ".local/share/keyrings"; }
    ];
  };
}
