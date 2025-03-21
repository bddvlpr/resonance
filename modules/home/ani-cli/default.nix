{
  pkgs,
  config,
  ...
}:
{
  home.packages = [ (pkgs.ani-cli.override { mpv = config.sysc.mpv.package; }) ];
}
