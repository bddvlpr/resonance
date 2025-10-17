{ inputs, ... }:
{
  imports = with inputs; [
    sops-nix.nixosModules.default
    home-manager.nixosModules.default
    nix-index-database.nixosModules.nix-index
  ];
}
