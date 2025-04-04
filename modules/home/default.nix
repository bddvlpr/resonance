{osConfig, ...}: {
  imports = [
    ./desktop
  ];

  home.stateVersion = osConfig.system.stateVersion;
}
