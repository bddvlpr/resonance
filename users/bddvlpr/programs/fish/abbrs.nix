{
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkMerge;
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in
mkMerge [
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
    sdr = "sudo darwin-rebuild --flake .";
    sdrb = "${sdr} build";
    sdrs = "${sdr} switch";
  })
  (mkIf isLinux rec {
    snr = "sudo nixos-rebuild --flake .";
    snrb = "${snr} boot";
    snrs = "${snr} switch";
  })
]
