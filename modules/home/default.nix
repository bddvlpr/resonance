{
  self,
  osConfig,
  pkgs,
  ...
}:
{
  imports = [
    ./desktop
    ./dev
    ./entertainment.nix
    ./persist.nix
    ./remote.nix
    ./secrets.nix
    ./user.nix
  ];

  home.stateVersion = self.lib.systemTernary pkgs {
    linux = osConfig.system.stateVersion;
    darwin = "25.05";
  };
}
