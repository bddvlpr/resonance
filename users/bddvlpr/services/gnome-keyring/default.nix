{
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in
{
  config = mkIf isLinux {
    services.gnome-keyring.enable = true;

    home.packages = [ pkgs.gcr ];

    bowl.persist.entries = [
      { path = ".local/share/keyrings"; }
    ];
  };
}
