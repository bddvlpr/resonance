{inputs, ...}: {
  imports = [
    inputs.sops-nix.nixosModules.default
    inputs.home-manager.nixosModules.default
    inputs.nix-index-database.nixosModules.nix-index
  ];
}
