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
  };

  hardware.nvidia.open = false;

  system.stateVersion = "25.05";
}
