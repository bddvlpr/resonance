{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.strings) hasSuffix;

  isDarwin = hasSuffix "-darwin" pkgs.system;
in {
  programs.zsh = {
    enable = true;

    shellAliases = let
      inherit (lib) getExe;

      build-command =
        if isDarwin
        then "darwin-rebuild --flake ~/.config/resonance"
        else "sudo nixos-rebuild --flake /etc/nixos";
    in rec {
      nb = "nix build";
      nbn = "${nb} nixpkgs#";
      nf = "nix flake";
      nfu = "${nf} update";
      nfmt = "nix fmt";
      nr = "nix run";
      nrn = "${nr} nixpkgs#";
      ns = "nix shell";
      nsn = "${ns} nixpkgs#";

      snr = build-command;
      snrs = "${snr} switch";

      cat = "${getExe pkgs.bat} -pp --theme=base16";
    };
  };
}
