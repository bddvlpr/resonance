{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      (symlinkJoin {
        name = "bambu-studio-with-mesa";
        paths = [ bambu-studio ];

        buildInputs = [ makeWrapper ];

        postBuild = ''
          wrapProgram $out/bin/bambu-studio \
            --set __GLX_VENDOR_LIBRARY_NAME mesa \
            --set __EGL_VENDOR_LIBRARY_FILENAMES ${mesa}/share/glvnd/egl_vendor.d/50_mesa.json
        '';
      })
    ];
    persistence."/persist/home/bddvlpr".directories = [
      ".config/BambuStudio"
    ];
  };
}
