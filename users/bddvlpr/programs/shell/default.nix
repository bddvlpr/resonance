{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe mkIf mkMerge;
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in {
  programs.fish = {
    enable = true;

    shellInit = ''
      set fish_greeting
    '';

    shellAbbrs = mkMerge [
      rec {
        nb = "nix build";
        nbn = "${nb} nixpkgs#";
        nf = "nix flake";
        nfu = "${nf} update";
        nfmt = "nix fmt";
        nr = "nix run";
        nrn = "${nr} nixpkgs#";
        ns = "nix shell";
        nsn = "${ns} nixpkgs#";
      }
      (mkIf isDarwin rec {
        dr = "darwin-rebuild --flake .";
        drb = "${dr} build";
        drs = "${dr} switch";
      })
      (mkIf isLinux rec {
        snr = "sudo nixos-rebuild --flake .";
        snrb = "${snr} boot";
        snrs = "${snr} switch";
      })
    ];

    shellAliases = {
      ls = "${getExe pkgs.eza}";
      cat = "${getExe pkgs.bat}";
    };
  };

  programs.starship = {
    enable = !isDarwin; # TODO: Currently looks terrible because the osx default terminal is limited.
    enableFishIntegration = true;
    enableZshIntegration = true;

    settings = {
      format = "$all";
    };
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "10x0";
      };
    };
  };
}
