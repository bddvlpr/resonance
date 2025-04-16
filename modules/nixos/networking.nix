{
  networking.networkmanager.enable = true;

  bowl.persist.entries = [
    {path = "/etc/NetworkManager";}
  ];
}
