{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.osu-lazer ];
    persistence."/persist/home/bddvlpr".directories = [ ".local/share/osu" ];
  };
}
