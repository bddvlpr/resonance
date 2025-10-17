{ inputs, ... }:
{
  imports = with inputs; [
    sops-nix.darwinModules.default
    home-manager.darwinModules.default
    nix-index-database.darwinModules.nix-index
  ];
}
