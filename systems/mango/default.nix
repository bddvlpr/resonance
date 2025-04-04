{
  imports = [./hardware.nix];

  bowl.disk.device = "/dev/vda";

  system.stateVersion = "25.05";
}
