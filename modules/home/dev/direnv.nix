{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  bowl.persist.entries = [
    { path = ".local/share/direnv"; }
  ];
}
