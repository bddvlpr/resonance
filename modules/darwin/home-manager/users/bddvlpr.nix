{outputs, ...}: {
  imports = with outputs.homeManagerModules; [
    dev
    fish
    git
    gpg
    helix
    zsh
  ];

  home.stateVersion = "24.05";
}
