{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) getExe;
in {
  ls = "${getExe pkgs.eza} --git --icons --group-directories-first";
  cat = "${getExe config.programs.bat.package} -pp";
}
