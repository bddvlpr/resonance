{pkgs, ...}: {
  services.gnome-keyring.enable = true;

  home = {
    packages = [pkgs.gcr];
    persistence."/persist/home/bddvlpr".directories = [
      ".local/share/keyrings"
    ];
  };
}
