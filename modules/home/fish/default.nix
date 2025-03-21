{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkIf mkOption types;
  inherit (pkgs.stdenv) isDarwin;

  cfg = config.sysc.fish;
in
{
  options.sysc.fish = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable fish.";
    };
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;

      shellAbbrs =
        let
          build-command =
            if isDarwin then
              "darwin-rebuild --flake ~/.config/resonance"
            else
              "sudo nixos-rebuild --flake /etc/nixos";
        in
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

          snr = build-command;
          snrb = "${snr} boot";
          snrs = "${snr} switch";
        };

      shellAliases =
        let
          inherit (lib) getExe;
        in
        {
          ls = "${getExe pkgs.eza} --icons -F -H --group-directories-first --git";
          cat = "${getExe pkgs.bat} -pp --theme=base16";
        };

      shellInit = ''
        set fish_greeting
        export TERM=xterm-256color
      '';
    };
  };
}
