{inputs, ...}: {
  imports = [
    inputs.sops-nix.nixosModules.default
    inputs.home-manager.nixosModules.default
  ];
}
