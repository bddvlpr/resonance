{pkgs, ...}: {
  programs.vscode = {
    enable = true;

    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      userSettings = {
        "editor.formatOnSave" = true;
        "editor.inlineSuggest.enabled" = true;
        "editor.minimap.autohide" = true;
        "editor.minimap.renderCharacters" = false;
        "explorer.autoReveal" = false;
        "explorer.excludeGitIgnore" = true;
        "extensions.autoUpdate" = false;
        "git.autofetch" = true;
        "security.workspace.trust.enabled" = false;
        "svelte.enable-ts-plugin" = true;
        "workbench.colorTheme" = "Catppuccin Macchiato";
        "workbench.iconTheme" = "catppuccin-macchiato";
        "workbench.startupEditor" = "none";
        "workbench.tree.indent" = 16;

        "rust-analyzer.lens.implementations.enable" = false;

        "[svelte]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };

        "[typescript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
      };

      extensions = with pkgs.vscode-extensions; [
        # Nix
        bbenoist.nix
        kamadorueda.alejandra

        # Rust
        rust-lang.rust-analyzer
        tamasfe.even-better-toml

        # Web
        svelte.svelte-vscode

        # Misc
        editorconfig.editorconfig
        usernamehw.errorlens
        eamodio.gitlens
        esbenp.prettier-vscode
        dbaeumer.vscode-eslint
        zxh404.vscode-proto3

        # Theme
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
      ];
    };
  };
}
