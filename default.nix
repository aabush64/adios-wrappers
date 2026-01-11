# If you're using npins, do `adiosPath = sources.adios.outPath;
# If you're using flakes, don't worry about it - this file will be called
# automaticlaly
{ adiosPath }:

let
  adios = (import "${adiosPath}/default.nix").adios;

  importModules = import "${adiosPath}/adios/lib/importModules.nix" {
    # Add my custom types
    adios = adios // rec {
      types = adios.types // {
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
