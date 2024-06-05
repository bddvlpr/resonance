{
  services.gnome-keyring.enable = true;

  home.persistence."/persist/home/bddvlpr".directories = [
    ".local/share/keyrings"
  ];
}
