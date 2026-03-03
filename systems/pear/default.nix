{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./home.nix
  ];

  sops.secrets."smb/credentials" = { };

  fileSystems =
    let
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=60"
        "x-systemd.device-timeout=5s"
        "x-systemd.mount-timeout=5s"
        "uid=bddvlpr"
        "gid=users"
        "file_mode=0700"
        "dir_mode=0700"
        "credentials=${config.sops.secrets."smb/credentials".path}"
      ];
    in
    {
      "/srv/backup" = {
        device = "//192.168.0.200/Backup";
        fsType = "cifs";
        inherit options;
      };
      "/srv/general" = {
        device = "//192.168.0.20/Algemeen";
        fsType = "cifs";
        inherit options;
      };
      "/srv/library" = {
        device = "//192.168.0.20/Bibliotheek";
        fsType = "cifs";
        inherit options;
      };
      "/srv/running-projects" = {
        device = "//192.168.0.20/Lopende\ Projecten";
        fsType = "cifs";
        inherit options;
      };
      "/srv/finished-projects" = {
        device = "//192.168.0.200/Afgewerkte\ Projecten";
        fsType = "cifs";
        inherit options;
      };
      "/srv/archived-projects" = {
        device = "//192.168.0.200/Gearchiveerde\ Projecten";
        fsType = "cifs";
        inherit options;
      };
      "/srv/renders" = {
        device = "//192.168.0.20/Renders";
        fsType = "cifs";
        inherit options;
      };
      "/srv/artifacts" = {
        device = "//192.168.0.199/Artifacts";
        fsType = "cifs";
        inherit options;
      };
      "/srv/xchange" = {
        device = "//192.168.0.20/XChange";
        fsType = "cifs";
        inherit options;
      };
    };

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
          "gamemode"
        ];
      };
    };

    desktop.autoLogin = {
      enable = true;
      user = "bddvlpr";
      command = "${pkgs.hyprland}/bin/start-hyprland";
    };

    virtualisation = {
      docker.enable = true;
      virtd.enable = true;
    };
  };

  time.timeZone = "Europe/Brussels";

  system.stateVersion = "25.05";
}
