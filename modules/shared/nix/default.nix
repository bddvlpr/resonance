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
      substituters = ["https://cache.garnix.io"];
      trusted-public-keys = ["cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="];
      experimental-features = ["nix-command" "flakes"];
    };
  };
}
