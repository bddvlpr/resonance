{ inputs', ... }:
{
  id = 0;
  name = "Personal";
  bookmarks = import ./bookmarks.nix;
  extensions = import ./extensions.nix {
    inherit (inputs'.nur.legacyPackages.repos.rycee) firefox-addons;
  };
}
