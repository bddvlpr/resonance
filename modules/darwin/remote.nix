{ inputs, ... }:
{
  imports = [
    inputs.sops-nix.darwinModules.default
    inputs.home-manager.darwinModules.default
    inputs.nix-index-database.darwinModules.nix-index
  ];
}
