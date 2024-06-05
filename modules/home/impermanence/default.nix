{inputs, ...}: let
  inherit (inputs.impermanence.nixosModules.home-manager) impermanence;
in {
  imports = [impermanence];

  config.home.persistence."/persist/home/bddvlpr" = {
    allowOther = true;
    directories = [
      "Documents"
      "Pictures"
      "Videos"
      "Desktop"
    ];
  };
}
