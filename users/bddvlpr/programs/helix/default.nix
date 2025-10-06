{ pkgs, ... }@args:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages =
      with pkgs;
      [
        docker-compose-language-service
        helm-ls
        nil
        nixd
        rust-analyzer
        taplo
        terraform-ls
        tinymist
        vscode-langservers-extracted
        yaml-language-server
      ]
      ++ (with nodePackages; [
        svelte-language-server
        typescript-language-server
      ]);

    languages = import ./languages.nix args;
    settings = import ./settings.nix args;
  };
}
