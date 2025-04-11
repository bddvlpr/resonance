{
  lib,
  self,
  ...
}: {
  flake.lib = rec {
    home = import ./home.nix {inherit lib;};
    secrets = import ./secrets.nix {inherit self;};
    system = import ./system.nix {inherit lib;};

    inherit (home) hasHome;
    inherit (secrets) mkSecret mkUserSecret;
    inherit (system) systemTernary;
  };
}
