# Pass the source for adios if you're using npins, not the instantiated module
{ adios }:

let
  adios' = (import "${adios}/default.nix").adios;
in
adios'.lib.importModules ./modules
