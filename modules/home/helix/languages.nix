{
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) getExe;
  inherit (pkgs) alejandra;
  inherit (pkgs.nodePackages) prettier;
  inherit (inputs.snippets-ls.packages.${pkgs.system}) snippets-ls;

  mkPrettier = {
    name,
    parser ? name,
    plugin ? null,
  }: {
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
          if plugin != null
          then ["--plugin" plugin]
          else []
        );
    };
  };
in {
  language = [
    (mkPrettier {name = "html";})
    (mkPrettier {name = "json";})
    (mkPrettier {name = "css";})
    (mkPrettier {name = "typescript";})
    (mkPrettier {
      name = "javascript";
      parser = "typescript";
    })
    (mkPrettier {
      name = "tsx";
      parser = "typescript";
    })
    ((
        mkPrettier {
          name = "svelte";
          parser = "svelte";
          plugin = "prettier-plugin-svelte";
        }
      )
      // {
        language-servers = ["svelteserver" "snippets-ls"];
      })
    {
      name = "nix";
      auto-format = true;
      formatter = {
        command = getExe alejandra;
      };
    }
    {
      name = "toml";
      auto-format = true;
    }
  ];

  language-server = {
    snippets-ls = {
      command = getExe snippets-ls;
      args = ["-config" ./snippets.json];
    };
  };
}
