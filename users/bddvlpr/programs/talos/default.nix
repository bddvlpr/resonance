{ pkgs, ... }:
{
  home.packages = with pkgs; [
    helmfile
    kubernetes-helm
    kubectl
    talosctl
  ];

  bowl.persist.entries = [
    { from = ".kube"; }
    { from = ".talos"; }
    { from = ".config/helm"; }
    { from = ".cache/helm"; }
    { from = ".local/share/helm"; }
  ];
}
