{ pkgs, lib, ... }:
let

  inherit (pkgs.stdenv.hostPlatform) isLinux;
in
{
  config = lib.mkIf isLinux {
    home.packages = [ pkgs.nextcloud-client ];

    bowl.persist.entries = [
      { path = ".config/Nextcloud"; }
      { path = "Nextcloud"; }
    ];
  };
}
