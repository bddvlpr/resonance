{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./home.nix
  ];

  bowl = {
    disk = {
      device = "/dev/nvme0n1";
      preset = "luks-btrfs-half";
    };

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

  system.stateVersion = "25.05";
}
