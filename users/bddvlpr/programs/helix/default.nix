{ pkgs, ... }@args:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      ameba-ls
      crystalline
      docker-compose-language-service
      helm-ls
      nil
      nixd
      rust-analyzer
      svelte-language-server
      taplo
      terraform-ls
      tinymist
      typescript-language-server
      vscode-langservers-extracted
      yaml-language-server
    ];

    languages = import ./languages.nix args;
    settings = import ./settings.nix args;
  };
}
