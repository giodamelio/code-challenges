# { pkgs ? import <nixpkgs> {} }:
let
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  nixpkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };
in
  nixpkgs.mkShell {
    buildInputs = [
      nixpkgs.latest.rustChannels.nightly.rust
      nixpkgs.latest.rustChannels.nightly.rust-src
      nixpkgs.rustracer
    ];
    RUST_SRC_PATH="${nixpkgs.latest.rustChannels.nightly.rust-src}/lib/rustlib/src/rust/src";
  }
