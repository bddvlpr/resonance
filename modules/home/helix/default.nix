{pkgs, ...} @ args: {
  programs.helix = {
    enable = true;

    languages = import ./languages.nix args;

    defaultEditor = true;
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
        vscode-langservers-extracted
      ]);
  };
}
