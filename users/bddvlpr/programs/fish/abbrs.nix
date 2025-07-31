{
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in
lib.mkMerge [
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
  (lib.mkIf isDarwin rec {
    sdr = "sudo darwin-rebuild --flake .";
    sdrb = "${sdr} build";
    sdrs = "${sdr} switch";
  })
  (lib.mkIf isLinux rec {
    snr = "sudo nixos-rebuild --flake .";
    snrb = "${snr} boot";
    snrs = "${snr} switch";
  })
]
