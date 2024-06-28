{outputs, ...}: {
  imports = with outputs.homeManagerModules; [
    dev
    fish
    git
    gpg
    helix
    vscode
    zsh
  ];

  home.stateVersion = "24.05";
}
