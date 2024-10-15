{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption optionals types;
  inherit (inputs.fenix.packages.${pkgs.system}) complete;
  inherit (inputs.schemat.packages.${pkgs.system}) schemat;
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
        schemat
      ]
      ++ (with pkgs; [
        cargo-watch
        file
        htop
        jq
        p7zip
        neofetch
        nodejs
        unzip
        usbutils
        zip
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
