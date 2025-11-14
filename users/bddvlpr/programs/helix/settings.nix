{ ... }:
{
  editor = {
    scrolloff = 8;
    line-number = "relative";
    bufferline = "multiple";

    cursor-shape = {
      insert = "bar";
      normal = "underline";
      select = "block";
    };

    inline-diagnostics = {
      cursor-line = "hint";
      other-lines = "error";
      max-diagnostics = 2;
    };

    statusline = {
      left = [
        "mode"
        "diagnostics"
        "spinner"
        "file-type"
      ];
      center = [
        "read-only-indicator"
        "file-name"
        "file-modification-indicator"
      ];
      right = [
        "workspace-diagnostics"
        "file-encoding"
        "file-line-ending"
        "version-control"
        "register"
        "position"
        "position-percentage"
      ];
    };

    lsp = {
      display-messages = true;
      display-progress-messages = true;
      display-inlay-hints = true;
    };

    auto-save = {
      focus-lost = true;
    };

    file-picker = {
      hidden = false;
      follow-symlinks = false;
    };

    indent-guides = {
      render = true;
      character = "┆";
    };

    whitespace.render = {
      tab = "all";
      nbsp = "all";
      nnbsp = "all";
    };

    soft-wrap.enable = true;
  };
}
