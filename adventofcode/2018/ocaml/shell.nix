{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    pkgs.ocaml
    pkgs.opam

    pkgs.m4
    pkgs.ncurses
  ];
  shellHook = ''
    mkdir -p .opam
    export OPAMROOT=$(pwd)/.opam
    opam init --disable-shell-hook
    eval $(opam env)
    opam install --yes utop
    eval $(opam env)
  '';
}
