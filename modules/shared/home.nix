{
  lib,
  config,
  inputs,
  inputs',
  self,
  ...
}:
{
  home-manager = {
    verbose = true;

    useUserPackages = true;
    useGlobalPkgs = true;

    extraSpecialArgs = { inherit inputs inputs' self; };

    users = lib.mapAttrs (name: _: self + /users/${name}) config.bowl.users;

    sharedModules = [ (self + /modules/home/default.nix) ];
  };
}
