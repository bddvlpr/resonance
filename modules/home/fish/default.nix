{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.strings) hasSuffix;

  isDarwin = hasSuffix "-darwin" pkgs.system;
in {
  programs.fish = {
    enable = true;

    shellAbbrs = let
      build-command =
        if isDarwin
        then "darwin-rebuild --flake ."
        else "sudo nixos-rebuild --flake /etc/nixos";
    in {
      n = "nix";
      nb = "nix build";
      nbn = "nix build nixpkgs#";
      nf = "nix flake";
      nfu = "nix flake update";
      nfmt = "nix fmt";
      nr = "nix run";
      nrn = "nix run nixpkgs#";
      ns = "nix shell";
      nsn = "nix shell nixpkgs#";

      snr = "${build-command} --flake /etc/nixos";
      snrs = "${build-command} switch";
    };

    shellAliases = let
      inherit (lib) getExe;
    in {
      ls = "${getExe pkgs.eza} --icons -F -H --group-directories-first --git";
      cat = "${getExe pkgs.bat} -pp --theme=base16";
    };

    shellInit = ''
      set fish_greeting
      export TERM=xterm-256color
    '';
  };
}