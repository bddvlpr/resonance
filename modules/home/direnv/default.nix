{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.persistence."/persist/home/bddvlpr".directories = [".local/share/direnv"];
}
