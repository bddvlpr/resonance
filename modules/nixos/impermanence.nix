{inputs, ...}: {
  imports = [inputs.impermanence.nixosModules.default];

  environment.persistence."/persist".directories = [
    "/var/lib/nixos"
    "/var/lib/systemd/coredump"
    "/var/log"
  ];
}
