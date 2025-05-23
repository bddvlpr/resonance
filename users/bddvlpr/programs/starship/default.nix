{pkgs, ...}: let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in {
  programs.starship = {
    enable = isLinux; # TODO: Currently looks terrible because the osx default terminal is limited.
    enableFishIntegration = true;
    enableZshIntegration = true;

    settings = {
      format = "$all";
    };
  };
}
