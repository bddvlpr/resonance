{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      (symlinkJoin {
        name = "orca-slicer-with-mesa";
        paths = [ orca-slicer ];

        buildInputs = [ makeWrapper ];

        postBuild = ''
          wrapProgram $out/bin/orca-slicer \
            --set __GLX_VENDOR_LIBRARY_NAME mesa \
            --set __EGL_VENDOR_LIBRARY_FILENAMES ${mesa}/share/glvnd/egl_vendor.d/50_mesa.json
        '';
      })
    ];
    persistence."/persist/home/bddvlpr".directories = [
      ".config/OrcaSlicer"
    ];
  };
}
