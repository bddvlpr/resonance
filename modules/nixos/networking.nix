{
  networking = {
    networkmanager.enable = true;
    wireless.enable = true;
  };

  bowl.persist.entries = [
    {path = "/etc/NetworkManager";}
  ];
}
