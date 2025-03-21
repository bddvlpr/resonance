{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.git;
in
{
  options.sysc.git = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable git.";
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      package = pkgs.gitFull;

      userName = "Luna Simons";
      userEmail = "luna@bddvlpr.com";

      signing = {
        key = "42EDAE8164B99C3A4B835711AB69B6F3380869A8";
        signByDefault = true;
      };

      extraConfig = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        credential.helper = "libsecret";
      };
    };
  };
}
