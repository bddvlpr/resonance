{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption types;
  inherit (inputs.fenix.packages.${pkgs.system}) complete;

  cfg = config.sysc.dev;
in {
  options.sysc.dev = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to set-up dev tools.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with complete;
      [
        cargo
        rustc
        rustfmt
      ]
      ++ (with pkgs; [
        cargo-watch
        gcc
        htop
        nodejs
      ])
      ++ (with pkgs.nodePackages; [
        yarn
        pnpm
      ]);
  };
}
