{ types, ... }:
{
  options = {
    pkgs = {
      type = types.attrs;
    };
    lib = {
      type = types.attrs;
      defaultFunc = { options }: options.pkgs.lib;
    };
  };

  meta = {
    maintainers = [ "llakala" ];
  };
}
