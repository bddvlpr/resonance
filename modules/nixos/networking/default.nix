{
  config,
  host,
  ...
}: let
  isImpermanent = config.sysc.impermanence.enable;
in {
  networking = {
    hostName = host;
    networkmanager.enable = true;
  };

  environment.persistence."/persist" = {
    enable = isImpermanent;
    directories = ["/etc/NetworkManager"];
  };
}
