{
  lib,
  pkgs,
  inputs,
  ...
}:
let
  inherit (lib) getExe;
  inherit (pkgs) nixfmt-rfc-style typstyle;
  inherit (pkgs.nodePackages) prettier;
  inherit (inputs.nix-steel.packages.${pkgs.system}) steel-language-server;

  mkPrettier =
    {
      name,
      parser ? name,
      plugin ? null,
    }:
    {
      inherit name;
      auto-format = true;
      formatter = {
        command = getExe prettier;
        args =
          [
            "--parser"
            parser
          ]
          ++ (
            if plugin != null then
              [
                "--plugin"
                plugin
              ]
            else
              [ ]
          );
      };
    };
in
{
  language = [
    (mkPrettier { name = "html"; })
    (mkPrettier { name = "json"; })
    (mkPrettier { name = "css"; })
    (mkPrettier { name = "typescript"; })
    (mkPrettier {
      name = "javascript";
      parser = "typescript";
    })
    (mkPrettier {
      name = "tsx";
      parser = "typescript";
    })
    (
      (mkPrettier {
        name = "svelte";
        parser = "svelte";
        plugin = "prettier-plugin-svelte";
      })
      // {
        language-servers = [ "svelteserver" ];
      }
    )
    {
      name = "nix";
      auto-format = true;
      formatter.command = getExe nixfmt-rfc-style;
    }
    {
      name = "toml";
      auto-format = true;
    }
    {
      name = "scheme";
      language-servers = [ "steel-language-server" ];
    }
    {
      name = "typst";
      auto-format = true;
      formatter.command = getExe typstyle;
    }
    {
      name = "gdscript";
      language-servers = [ "godot" ];
    }
  ];

  language-server = {
    steel-language-server = {
      command = getExe steel-language-server;
      args = [ ];
    };

    godot = {
      command = "${getExe pkgs.netcat}";
      args = [
        "127.0.0.1"
        "6005"
      ];
    };
  };
}
