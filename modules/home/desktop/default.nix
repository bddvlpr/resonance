{lib, ...}: let
  inherit (lib) mkOption types;
in {
  imports = [
    ./hyprland.nix
  ];

  options.bowl.desktop = {
    environment = mkOption {
      type = types.enum ["hyprland"];
      default = "hyprland";
      description = "Which desktop environment to use for this user.";
    };
  };
}
