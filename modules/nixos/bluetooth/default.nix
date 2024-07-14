{pkgs, ...}: {
  hardware.bluetooth.enable = true;

  environment = {
    systemPackages = [pkgs.bluetuith];
    persistence."/persist".directories = [
      "/var/lib/bluetooth"
    ];
  };
}
