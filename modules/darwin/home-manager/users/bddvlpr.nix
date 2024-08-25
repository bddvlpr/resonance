{
  outputs,
  lib,
  ...
}: {
  imports = with outputs.homeManagerModules; [
    comma
    dev
    direnv
    fish
    fzf
    git
    gitui
    gpg
    helix
    impermanence
    mpv
    starship
    steel
    vscode
    zsh
  ];

  # Shim to disable persistence
  home.persistence = lib.mkForce {};

  home.stateVersion = "24.05";
}
