{osConfig, ...}: {
  imports = [
    ./desktop
    ./dev
    ./user.nix
  ];

  home.stateVersion = osConfig.system.stateVersion;
}
