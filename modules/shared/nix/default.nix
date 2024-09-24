{
  lib,
  inputs,
  ...
}: let
  inherit (lib) filterAttrs isType mapAttrs mapAttrsToList;

  flakeInputs = filterAttrs (_: isType "flake") inputs;
in {
  nix = {
    registry = mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    settings = {
      warn-dirty = false;
      substituters = [
        "https://cache.garnix.io"
        "https://nix-community.cachix.org"
        "https://helix.cachix.org"
        "https://ezkea.cachix.org"
      ];
      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      ];
      trusted-users = ["bddvlpr"];
      experimental-features = ["nix-command" "flakes"];
    };
  };
}
