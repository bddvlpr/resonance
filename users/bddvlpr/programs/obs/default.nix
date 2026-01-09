{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override { cudaSupport = true; };
    plugins = with pkgs.obs-studio-plugins; [
      obs-backgroundremoval
      obs-command-source
      obs-dvd-screensaver
    ];
  };

  bowl.persist.entries = [
    { from = ".config/obs-studio"; }
  ];
}
