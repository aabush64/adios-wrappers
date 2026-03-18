# Pass the source for adios if you're using npins, not the instantiated module
{ adios } @ sources:

let
  adios = import sources.adios;
in
adios.lib.importModules ./modules
