# Overlay: build rofi-unwrapped from upstream's `next` branch instead of the
# `2.0.0` tag, to pick up the fix for the Wayland SIGBUS crash in
# wayland_rofi_view_repaint (pixman_fill on a truncated/stale shm mapping).
#
# Not yet in a tagged release, so plain nixpkgs (pinned to tag 2.0.0) still
# has the bug. Remove this once rofi cuts a release containing the fix and
# nixpkgs bumps to it.
#
# https://github.com/davatorium/rofi/issues/2252
# https://github.com/davatorium/rofi/pull/2292
final: prev: {
  rofi-unwrapped = prev.rofi-unwrapped.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "davatorium";
      repo = "rofi";
      rev = "f1ee9b8e4a612ce7d13eeb57f8fe81b985900071"; # next HEAD as of 2026-08-26, includes #2292
      fetchSubmodules = true;
      hash = "sha256-Vqiqyq1KTr0DfSFr7FD7rG9wnWqrkZTobjLfR/aOkcQ=";
    };
  });
}
