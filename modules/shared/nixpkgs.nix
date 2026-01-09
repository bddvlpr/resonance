{ inputs, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };

    overlays = [ inputs.nixpkgs-xr.overlays.default ];
  };
}
