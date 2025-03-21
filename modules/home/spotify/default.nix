{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [ spotify-player ];

    persistence."/persist/home/bddvlpr".directories = [
      ".config/spotify-player"
      ".cache/spotify-player"
    ];
  };
}
