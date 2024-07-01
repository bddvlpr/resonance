{
  lib,
  config,
  pkgs,
  ...
} @ args: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.helix;
in {
  imports = [./steel];

  options.sysc.helix = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable helix.";
    };

    enableSteel = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable Steel plugins.";
    };
  };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;

      languages = import ./languages.nix args;
      settings = import ./settings.nix args;

      extraPackages = with pkgs;
        [
          buf-language-server
          docker-compose-language-service
          gleam
          gopls
          haskell-language-server
          helm-ls
          kotlin-language-server
          lldb
          marksman
          netcoredbg
          nil
          omnisharp-roslyn
          rust-analyzer
          taplo
          terraform-ls
          texlab
          yaml-language-server
          zls
        ]
        ++ (with nodePackages; [
          svelte-language-server
          typescript-language-server
          vscode-langservers-extracted
        ]);
    };
  };
}
