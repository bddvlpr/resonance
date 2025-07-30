{
  lib,
  pkgs,
  config,
  ...
}:
{
  programs.fish = {
    enable = true;

    shellInit = ''
      set fish_greeting
    '';

    shellAbbrs = import ./abbrs.nix { inherit lib pkgs; };
    shellAliases = import ./aliases.nix { inherit lib pkgs config; };
  };
}
