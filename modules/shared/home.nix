{
  lib,
  config,
  self,
  ...
}: let
  inherit (lib) mapAttrs;
in {
  home-manager = {
    verbose = true;

    useUserPackages = true;
    useGlobalPkgs = true;

    users = mapAttrs (name: _: self + "/users/${name}") config.bowl.users;
  };
}
