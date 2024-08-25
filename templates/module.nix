{
  flake.templates = rec {
    parts = {
      path = ./parts;
      description = "Flake-parts based flake with support for darwin and linux";
    };

    parts-with-direnv = {
      path = ./parts-with-direnv;
      description = "Flake-parts based flake with support for darwin and linux with direnv config";
    };

    default = parts;
  };
}
