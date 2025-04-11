args: {
  flake.lib = rec {
    home = import ./home.nix args;
    secrets = import ./secrets.nix args;
    system = import ./system.nix args;

    inherit (home) hasHome;
    inherit (secrets) mkSecret mkUserSecret;
    inherit (system) systemTernary;
  };
}
