{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-hyprland];
    configPackages = with pkgs; [hyprland];
  };
}
