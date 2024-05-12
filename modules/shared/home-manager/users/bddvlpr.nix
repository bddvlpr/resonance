{outputs, ...}: {
  imports = builtins.attrValues outputs.homeManagerModules;

  home.stateVersion = "24.05";
}
