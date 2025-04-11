{inputs, ...}: {
  imports = [
    inputs.sops-nix.darwinModules.default
    inputs.home-manager.darwinModules.default
  ];
}
