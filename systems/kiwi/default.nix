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
        groups = [ "gamemode" ];
      };
    };

    desktop.autoLogin = {
      enable = true;
      user = "bddvlpr";
      command = "${pkgs.hyprland}/bin/start-hyprland";
    };
  };

  time.timeZone = "Europe/Brussels";

  system.stateVersion = "25.05";
}
