{
  self,
  osConfig,
  pkgs,
  ...
}: let
  inherit (self.lib) systemTernary;
in {
  imports = [
    ./desktop
    ./dev
    ./persist.nix
    ./remote.nix
    ./secrets.nix
    ./user.nix
  ];

  home.stateVersion = systemTernary pkgs {
    linux = osConfig.system.stateVersion;
    darwin = "25.05";
  };
}
