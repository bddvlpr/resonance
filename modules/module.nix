{
  flake = {
    darwinModules = import ./darwin;
    homeManagerModules = import ./home;
    nixosModules = import ./nixos;
    sharedModules = import ./shared;
  };
}
