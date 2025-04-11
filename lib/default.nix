{
  lib,
  self,
  ...
}: {
  flake.lib = rec {
    home = import ./home.nix {inherit lib;};
    secrets = import ./secrets.nix {inherit self;};

    inherit (home) hasHome;
    inherit (secrets) mkSecret mkUserSecret;
  };
}
