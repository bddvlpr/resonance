{
  flake = {
    homeManagerModules = import ./home;
    nixosModules = import ./nixos;
    sharedModules = import ./shared;
  };
}
