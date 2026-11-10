# niri super + shift + left-drag resizing

patches `src/input/mod.rs` so that:
- super + left-drag moves windows
- super + shift + left-drag resizes windows
- super + right-drag still resizes windows

overview mode retains its own mouse behavior

## nixos use

place both the `.patch` and `niri-resize-overlay.nix` in your configuration repository, for example `./overlays/niri/`

in your system module:

```nix
{ ... }: {
  nixpkgs.overlays = [ (import ./overlays/niri/niri-resize-overlay.nix) ];
  programs.niri.enable = true;
}
```

adjust the import path to match your repo, and rebuild with your normal `nixos-rebuild switch --flake ...`

## important

this patch targets the niri `main` source inspected on 2026-11-09, and has not been compiled or runtime tested here, because network access to clone and a nix build environment were unavailable

nix will fail at patch application if the corresponding source no longer matches, which is safer than silently patching some unrelated code

if `programs.niri.package` is explicitly assigned in your config, ensure it points to `pkgs.niri` so the overlaid package is used
