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
        groups = [ "docker" ];
      };
    };

    desktop.autoLogin = {
      enable = true;
      user = "bddvlpr";
      package = pkgs.hyprland;
    };

    virtualisation.docker.enable = true;
  };

  time.timeZone = "Europe/Brussels";

  system.stateVersion = "25.05";
}
