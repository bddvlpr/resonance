{
  self,
  inputs,
  ...
}: {
  imports = [inputs.easy-hosts.flakeModule];

  easyHosts = {
    perClass = class: {
      modules = [
        "${self}/modules/${class}/default.nix"
        "${self}/modules/shared/default.nix"
      ];
    };

    hosts = {
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
