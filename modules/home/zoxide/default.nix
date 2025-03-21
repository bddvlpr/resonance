{
  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  home.persistence."/persist/home/bddvlpr".directories = [
    ".local/share/zoxide"
  ];
}
