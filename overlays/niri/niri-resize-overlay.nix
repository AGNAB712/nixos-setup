final: prev: {
  niri = prev.niri.overrideAttrs (old: {
    patches = (old.patches or []) ++ [
      ./super-shift-left-resize.patch
      ./rofi-slide-animation.patch
    ];
  });
}