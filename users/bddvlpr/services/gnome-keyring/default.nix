{pkgs, ...}: {
  services.gnome-keyring.enable = true;

  home.packages = [pkgs.gcr];

  bowl.persist.entries = [
    {path = ".local/share/keyrings";}
  ];
}
