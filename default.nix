{ adios } @ args:

let
  warn = builtins.warn or builtins.trace;
  adios =
    if builtins.isAttrs args.adios then
    args.adios
    else
      warn ''
        The adios-wrappers 'default.nix' now expects to be passed an instantiated `adios` function, rather than the source.

        Where one would previously do:
        ```
          adios = import sources.adios;
          adios-wrappers = import sources.adios-wrappers { adios = sources.adios; }
        ```
        Instead, do:
        ```
          adios = import sources.adios;
          adios-wrappers = import sources.adios-wrappers { inherit adios; }
        ```

      '' (import args.adios);
in

adios.lib.importModules ./modules
