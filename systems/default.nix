{
  inputs,
  self,
  lib,
  ...
}: let
  inherit (lib) optionals;
in {
  imports = [inputs.easy-hosts.flakeModule];

  easy-hosts = {
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
      kiwi = {
        arch = "x86_64";
        class = "nixos";
      };

      lychee = {
        arch = "x86_64";
        class = "darwin";
      };

      strawberry = {
        arch = "x86_64";
        class = "nixos";
      };
    };
  };
}
