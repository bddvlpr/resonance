{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption optionals types;
  inherit (inputs.fenix.packages.${pkgs.system}) complete;
  inherit (pkgs.stdenv) isDarwin;

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
    home.packages =
      [
        (complete.withComponents
          [
            "cargo"
            "clippy"
            "rust-src"
            "rustc"
            "rustfmt"
          ])
      ]
      ++ (with pkgs; [
        cargo-watch
        htop
        nodejs
      ])
      ++ (with pkgs.nodePackages; [
        yarn
        pnpm
      ])
      ++ optionals (!isDarwin) (with pkgs; [
        gcc
      ]);
  };
}
