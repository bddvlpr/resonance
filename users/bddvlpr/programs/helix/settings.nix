{...}: {
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
        "spinner"
        "diagnostics"
      ];
      center = [
        "file-name"
        "read-only-indicator"
        "file-modification-indicator"
      ];
      right = [
        "version-control"
        "selections"
        "register"
        "position"
        "position-percentage"
        "file-encoding"
      ];
    };

    lsp = {
      display-messages = true;
      display-inlay-hints = true;
    };

    indent-guides.render = true;
    soft-wrap.enable = true;
  };
}
