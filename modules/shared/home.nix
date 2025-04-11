{
  lib,
  config,
  inputs,
  inputs',
  self,
  ...
}: let
  inherit (lib) mapAttrs;
in {
  home-manager = {
    verbose = true;

    useUserPackages = true;
    useGlobalPkgs = true;

    extraSpecialArgs = {inherit inputs inputs' self;};

    users = mapAttrs (name: _: self + /users/${name}) config.bowl.users;

    sharedModules = [(self + /modules/home/default.nix)];
  };
}
