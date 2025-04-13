{
  imports = [./hardware.nix];

  bowl = {
    disk.device = "/dev/vda";

    users = {
      bddvlpr = {
        superuser = true;
      };
    };
  };

  system.stateVersion = "25.05";
}
