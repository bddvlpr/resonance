{
  networking.networkmanager.enable = true;

  services.tailscale.enable = true;

  bowl.persist.entries = [
    {path = "/etc/NetworkManager";}
    {path = "/var/lib/tailscale";}
  ];
}
