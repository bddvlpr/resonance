{
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in
{
  fonts = {
    fontDir.enable = lib.mkIf isLinux true;
    packages =
      with pkgs;
      [
        geist-font
        iosevka
      ]
      ++ (with nerd-fonts; [
        iosevka
        geist-mono
        zed-mono
      ]);
  };
}
