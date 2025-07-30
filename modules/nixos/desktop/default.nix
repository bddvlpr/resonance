{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  imports = [
    ./environments.nix
    ./login.nix
    ./xdg.nix
  ];

  options.bowl.desktop = {
    autoLogin = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to auto-login the user or not.
          Refrain from using autoLogin if the disk is not password protected!
        '';
      };

      user = mkOption {
        type = types.str;
        description = "The user to auto-login as.";
      };

      package = mkOption {
        type = types.package;
        description = "The environment to load in to.";
      };
    };

    loginManager = mkOption {
      type = types.enum [ "greetd" ];
      default = "greetd";
      description = "Which login manager to use.";
    };
  };

  config = {
    programs.dconf.enable = true;
  };
}
