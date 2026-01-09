{ inputs', ... }:
{
  id = 1;
  name = "Work";
  bookmarks = import ./bookmarks.nix;
  extensions = import ./extensions.nix {
    inherit (inputs'.nur.legacyPackages.repos.rycee) firefox-addons;
  };
}
