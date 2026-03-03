{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.bowl.ai;
in
{
  options.bowl.ai = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
      user = "ollama";
      group = "ollama";
      loadModels = [
        "deepseek-r1:14b"
        "llama:16x17b"
        "qwen3-coder:30b"
      ];
    };

    systemd = {
      services.ollama.serviceConfig.DynamicUser = lib.mkForce false;
      tmpfiles.rules = [
        "d /var/lib/ollama/models 0700 ollama ollama - -"
      ];
    };

    bowl.persist.entries = [
      {
        from = "/var/lib/ollama";
        user = "ollama";
        group = "ollama";
        mode = "0700";
      }
    ];
  };
}
