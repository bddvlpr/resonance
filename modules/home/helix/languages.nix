{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe;
  inherit (pkgs) alejandra;
  inherit (pkgs.nodePackages) prettier;

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
    (mkPrettier {
      name = "svelte";
      parser = "typescript";
      plugin = "prettier-plugin-svelte";
    })
    {
      name = "nix";
      auto-format = true;
      formatter = {
        command = getExe alejandra;
      };
    }
  ];
}
