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
      strawberry = {
        arch = "x86_64";
        class = "nixos";
      };
    };
  };
}
