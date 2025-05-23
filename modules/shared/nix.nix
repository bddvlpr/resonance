{
  lib,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib) filterAttrs isType mapAttrs mapAttrsToList;

  flakeInputs = filterAttrs (_: isType "flake") inputs;
in {
  nix = {
    # package = pkgs.lix;

    registry = mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

    settings = {
      warn-dirty = false;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = ["@wheel" "@admin"];
      substituters = [
        "https://cache.garnix.io"
        "https://nix-community.cachix.org"
        "https://ezkea.cachix.org"
      ];
      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      ];
    };
  };
}
