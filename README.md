# Resonance

![Desktop](https://i.imgur.com/ZkmIEoj.png)

My opinionated Nix system and module files (may contain traces of pkgs and overlays).

## Structure

Everything is split up in separate flake-parts. Why? I have no clue.
```
.
├── apps                     # Any apps I've used. I think this is empty.
├── lib                      # Usually functions I share between flakes or modules are put here.
├── modules                  # Modules are split up in their respective directories. Depending on the host, the correct ones will be imported.
│   ├── darwin               # Darwin modules; only OSX hosts will import these.
│   ├── home                 # Home manager modules; all home manager users will import these.
│   ├── nixos                # NixOS modules; only NixOS hosts will import these.
│   └── shared               # Shared modules; all hosts will import these on root config level.
├── overlays                 # I generally do not like using overlays.
│   └── pkgs                 # Just overlays the local pkgs in /pkgs/ onto the pkgs attribute.
├── pkgs                     # Packages I use or require without wanting to make a nixpkgs pr.
└── systems                  # All systems are listed here.
    ├── dissension
    └── solaris
```
