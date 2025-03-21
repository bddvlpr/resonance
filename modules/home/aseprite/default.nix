{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.aseprite ];
    persistence."/persist/home/bddvlpr".directories = [ ".config/aseprite" ];
  };
}
