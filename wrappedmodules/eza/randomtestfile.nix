let
  inherit (builtins) concatStringsSep attrValues;
in
{
  colorValues = {
    fg1 = {
      rgb = {
        r = 24;
        g = 24;
        b = 24;
        __functor = self: _:
                  concatStringsSep ","
                  map
                  toString (
                    attrValues (removeAttrs self ["__functor"])
                  );

      };
    };
  };
}
