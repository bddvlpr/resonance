{
  lib,
  pkgs,
  ...
}: {
  programs.fish = {
    enable = true;

    shellAbbrs = {
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

      snr = "sudo nixos-rebuild --flake /etc/nixos";
      snrs = "sudo nixos-rebuild --flake /etc/nixos switch";
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
