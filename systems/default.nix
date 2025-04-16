{
  inputs,
  self,
  lib,
  ...
}: let
  inherit (lib) optionals;
in {
  imports = [inputs.easy-hosts.flakeModule];

  easyHosts = {
    perClass = class: {
      modules =
        [
          "${self}/modules/${class}/default.nix"
          "${self}/modules/shared/default.nix"
        ]
        ++ (optionals (class != "iso") [
          "${self}/modules/shared/home.nix"
        ]);
    };

    hosts = {
      lychee = {
        arch = "x86_64";
        class = "darwin";
      };

      mango = {
        arch = "x86_64";
        class = "nixos";
      };

      strawberry = {
        arch = "x86_64";
        class = "nixos";
      };
    };
  };
}
