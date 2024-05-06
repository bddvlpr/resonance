{
  nix.settings = {
    warn-dirty = false;
    substituters = ["https://cache.garnix.io"];
    trusted-public-keys = ["cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="];
    experimental-features = ["nix-command" "flakes"];
  };
}
