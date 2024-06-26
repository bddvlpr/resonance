args: {
  flake = {
    darwinModules = import ./darwin args;
    homeManagerModules = import ./home args;
    nixosModules = import ./nixos args;
    sharedModules = import ./shared args;
  };
}
