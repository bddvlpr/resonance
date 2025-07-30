{
  lib,
  config,
  inputs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.bowl.disk;
in
{
  imports = [ inputs.disko.nixosModules.default ];

  options.bowl.disk = {
    enable = mkEnableOption "Automatic disk setup" // {
      default = true;
    };

    preset = mkOption {
      type = types.enum [ "luks-btrfs" ];
      default = "luks-btrfs";
      description = ''
        Which template to use for automatic disk setup.
        View the files in ${./disk-templates} for more details.
      '';
    };

    device = mkOption {
      type = types.str;
      description = "The device to use for the set disk template.";
    };

    swap = mkOption {
      type = types.str;
      default = "8G";
      description = "The amount of space to allocate to swap (if defined in the template).";
    };
  };

  config = mkIf cfg.enable {
    disko = import ./disk-templates/${cfg.preset}.nix {
      inherit (cfg) device swap;
    };

    fileSystems = {
      "/nix".neededForBoot = true;
      "/persist".neededForBoot = true;
    };
  };
}
