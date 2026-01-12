Thank you for wanting to contribute to the project!

More modules and options are always welcome. However, they're expected to follow some style guides.

# RFC42 and impure options

Each option should have an RFC42 variant and an impure path variant.

An RFC42 option is what you're familiar with from nixos or home-manager, where the attribute set is automatically
transformed into the correct language.

An impure path variant may be less familiar to you. All the wrappers in adios-wrappers aim to support an impure mode. If
the user runs toString on a config file they've provided (ex: `configFile = toString ./gitconfig;`), then the path won't
be copied to the nix store, and will instead be turned into a string which is read from at runtime. This means the user
can run their program and have it always use the newest version.

Any new configuration options should be added with both variants, with checks that the options aren't both set at once.
Here's an example module that adds both:

```nix
{
  name = "foo";

  inputs = {
    nixpkgs.path = "/nixpkgs";
    mkWrapper.path = "/mkWrapper";
  };

  options = {
    settings = {
      type = types.attrs;
      description = ''
        Settings injected into the wrapped package's `foo.toml`.

        See the documentation for valid options:
        https://fake.website.com

        Disjoint with the `configFile` option.
      '';
    };
    configFile = {
      type = types.pathLike;
      description = ''
        `foo.toml` file to be injected into the wrapped package.

        See the documentation for valid options:
        https://fake.website.com

        Disjoint with the `settings` option.
      '';
    };
  };
  impl =
    { options, inputs }:
    let
      generator = inputs.nixpkgs.pkgs.formats.toml {};
    in
    assert !(options ? settings && options ? configFile);
    inputs.mkWrapper {
      environment.FOO_CONFIG_PATH = options.configFile or (generator.generate "config" options.settings);
    };
}
```

# Description guidelines
TODO

# mkWrapper usage
TODO

# Docs generation
TODO
