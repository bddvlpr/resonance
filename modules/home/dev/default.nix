{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption types;

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
    home.packages = with pkgs;
      [
        cargo
        clippy
        gcc
        htop
        nodejs
        rustc
        rustfmt
      ]
      ++ (with nodePackages; [
        yarn
        pnpm
      ]);
  };
}
