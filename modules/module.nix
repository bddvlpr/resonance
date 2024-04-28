{
  flake = {
    nixosModules = import ./nixos;
    sharedModules = import ./shared;
  };
}
