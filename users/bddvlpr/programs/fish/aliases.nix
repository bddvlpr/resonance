{
  lib,
  pkgs,
  config,
  ...
}:
{
  ls = "${lib.getExe pkgs.eza} --git --icons --group-directories-first";
  cat = "${lib.getExe config.programs.bat.package} -pp";
}
