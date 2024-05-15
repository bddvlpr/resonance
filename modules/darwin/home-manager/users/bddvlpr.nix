{outputs, ...}: {
  imports = with outputs.homeManagerModules; [
    fish
    git
    gpg
    helix
    zsh
  ];

  home.stateVersion = "24.05";
}
