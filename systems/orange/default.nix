{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./home.nix
  ];

  bowl = {
    disk = {
      device = "/dev/sdb";
      preset = "luks-btrfs";
    };

    users = {
      bddvlpr = {
        superuser = true;
        groups = [
          "docker"
          "libvirtd"
          "gamemode"
        ];
      };
    };

    desktop.autoLogin = {
      enable = true;
      user = "bddvlpr";
      command = "${pkgs.hyprland}/bin/start-hyprland";
    };
  };

  time.timeZone = "Europe/Brussels";

  system.stateVersion = "25.11";
}
