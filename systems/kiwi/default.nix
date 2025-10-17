{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./home.nix
  ];

  bowl = {
    disk.device = "/dev/nvme0n1";

    users = {
      bddvlpr = {
        superuser = true;
      };
    };

    desktop.autoLogin = {
      enable = true;
      user = "bddvlpr";
      package = pkgs.hyprland;
    };
  };

  time.timeZone = "Europe/Brussels";

  system.stateVersion = "25.05";
}
