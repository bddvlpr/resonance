{ inputs', ... }:
{
  services.mullvad-vpn = {
    enable = true;
    package = inputs'.nixpkgs-stable.legacyPackages.mullvad-vpn;
  };

  environment.persistence."/persist".directories = [
    "/etc/mullvad-vpn"
  ];
}
