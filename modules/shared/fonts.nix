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
  fonts = {
    fontDir.enable = mkIf isLinux true;
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
