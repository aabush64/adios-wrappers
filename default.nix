# Pass the source for adios if you're using npins, not the instantiated module
{ adios }:

let
  adiosLib = (import "${adios}/default.nix").adios;

  importModules = import "${adios}/adios/lib/importModules.nix" {
    # Add my custom types
    adios = adiosLib // rec {
      types = adiosLib.types // {
        null = types.typedef "null" isNull;
        pathLike = types.union [
          types.path
          types.derivation
          types.string
        ];
      };
    };
  };
in
importModules ./modules
