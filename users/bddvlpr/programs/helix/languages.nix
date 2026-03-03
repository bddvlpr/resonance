{ lib, pkgs, ... }:
{
  language-server.biome = {
    command = lib.getExe pkgs.biome;
    args = [ "lsp-proxy" ];
  };

  language = [
    {
      name = "nix";
      auto-format = true;
    }
    {
      name = "javascript";
      language-servers = [
        {
          name = "typescript-language-server";
          except-features = [ "format" ];
        }
        "biome"
      ];
      auto-format = true;
    }
    {
      name = "typescript";
      language-servers = [
        {
          name = "typescript-language-server";
          except-features = [ "format" ];
        }
        "biome"
      ];
      auto-format = true;
    }
    {
      name = "tsx";
      language-servers = [
        {
          name = "typescript-language-server";
          except-features = [ "format" ];
        }
        "biome"
      ];
      auto-format = true;
    }
    {
      name = "jsx";
      language-servers = [
        {
          name = "typescript-language-server";
          except-features = [ "format" ];
        }
        "biome"
      ];
      auto-format = true;
    }
    {
      name = "json";
      language-servers = [
        {
          name = "vscode-json-language-server";
          except-features = [ "format" ];
        }
        "biome"
      ];
      auto-format = true;
    }
  ];
}
