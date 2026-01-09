{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  bowl.persist.entries = [
    { from = ".local/share/direnv"; }
  ];
}
