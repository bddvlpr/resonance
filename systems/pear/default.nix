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
        groups = [
          "docker"
          "libvirtd"
        ];
      };
    };

    desktop.autoLogin = {
      enable = true;
      user = "bddvlpr";
      package = pkgs.hyprland;
    };

    virtualisation = {
      docker.enable = true;
      virtd.enable = true;
    };
  };

  time.timeZone = "Europe/Brussels";

  system.stateVersion = "25.05";
}
