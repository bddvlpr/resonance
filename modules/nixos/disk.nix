{
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.bowl.disk;
in
{
  imports = [ inputs.disko.nixosModules.default ];

  options.bowl.disk = {
    enable = lib.mkEnableOption "Automatic disk setup" // {
      default = true;
    };

    preset = lib.mkOption {
      type = lib.types.enum [
        "luks-btrfs"
        "luks-btrfs-half"
      ];
      default = "luks-btrfs";
      description = ''
        Which template to use for automatic disk setup.
        View the files in ${./disk-templates} for more details.
      '';
    };

    device = lib.mkOption {
      type = lib.types.str;
      description = "The device to use for the set disk template.";
    };

    swap = lib.mkOption {
      type = lib.types.str;
      default = "8G";
      description = "The amount of space to allocate to swap (if defined in the template).";
    };
  };

  config = lib.mkIf cfg.enable {
    disko = import ./disk-templates/${cfg.preset}.nix {
      inherit (cfg) device swap;
    };

    fileSystems = {
      "/nix".neededForBoot = true;
      "/persist".neededForBoot = true;
    };
  };
}
