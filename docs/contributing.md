Thank you for wanting to contribute to the project!

More modules and options are always welcome. However, they're expected to follow some style guides.

## RFC42 and impure options

Each option should aim to have an RFC42 variant and an impure path variant.

An RFC42 option is what you're familiar with from nixos or home-manager, where the attribute set is automatically
transformed into the correct language.

An impure path variant may be less familiar to you. All the wrappers in adios-wrappers aim to support an impure mode. If
the user runs toString on a config file they've provided (ex: `configFile = toString ./gitconfig;`), then the path won't
be copied to the nix store, and will instead be turned into a string which is read from at runtime. This means the user
can run their program and have it always use the newest version.

Any new configuration options should be added with both variants, with checks that the options aren't both set at once.
Here's an example module that adds both:

```nix
{ types, ... }:
{
  inputs = {
    nixpkgs.from = { parent }: parent.nixpkgs;
    mkWrapper.from = { parent }: parent.mkWrapper;
  };

  options = {
    settings = {
      type = types.attrs;
      description = ''
        Settings to be injected into the wrapped package's `foo.toml`.

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

    package = {
      type = types.derivation;
      description = "The foo package to be wrapped.";
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.foo;
    };
  };
  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs.pkgs) formats;
      generator = formats.toml {};
    in
    assert !(options ? settings && options ? configFile);
    inputs.mkWrapper {
      symlinks = {
        "$out/foo/foo.toml" =
          if options ? configFile then
            options.configFile
          else if options ? settings then
            generator.generate "$out/foo/foo.toml" options.settings
          else
            null;
      };
      environment = {
        FOO_CONFIG_FILE = "$out/foo/foo.toml";
      };
    };
}
```

## Choosing where to source your generators

There are lots of ways to turn a `settings` option into a file that can be used in `symlinks`. However, where possible,
we prefer to source from `pkgs.formats`. Formats automatically create a file for you, so the wrappers don't have to call
`writeTextFile` themselves. Formats are also the standard for repos like nixpkgs and home-manager. If you have the
choice between using something from `builtins`, `lib.generators`, or `pkgs.formats`, please choose formats!

## Description guidelines

All newly introduced options should come with descriptions. These descriptions should follow the established format
that's been used in the other modules. To ease this experience, a template is provided for the most common types of
option.

### `settings`

```nix
description = ''
  Settings to be injected into the wrapped package's `$FILE_NAME`.

  See the documentation for $DOCS_REASON:
  $DOCS_LINK_HERE

  Disjoint with the `configDir` option.
'';
```

The documentation section is optional if there's not a good link, but trying to find one would be nice.

### `configFile`

```nix
description = ''
  `$FILE_NAME` file to be injected into the wrapped package.

  See the documentation for $DOCS_REASON:
  $DOCS_LINK_HERE

  Disjoint with the `settings` option.
'';
```

### `flags`

```nix
description = ''
  Flags to be automatically appended when running $PROGRAM_NAME.

  See the documentation for $DOCS_REASON:
  $DOCS_LINK_HERE

  Disjoint with the `$DISJOINT_OPTION` option.
'';
```

### `package`

```nix
description = "The $program_name package to be wrapped.";
```

## Option Naming 

Option names typically take the form of `optionMethod` (camelCase) where `option` is the descriptor of what is being
changed/injected, and `Method` describes how the option is being implemented. For example:

`completions`: Option that generates completions from a nix attrset

`completionsFiles`: Option that generates completions by importing files

When writing modules, options that only differ in suffix do not contain whitespaces between them, all other options
should have whitespace between them.

The section below contains naming convetions often used in module options and their expected uses.

### Naming Conventions

#### Options

Not all options listed are required to be in the module, with the exception of `package` when wrapping a derivation.

`config`/`settings`: Options that set a package's primary configuration file (eg. `.rc`, `.json`, `.ini`, `.yaml` files),
only one of the two naming choices should be used throughout the module to reduce confusion.

`flags`: Options that set the command line flags passed to the wrapped package.

`package`: Option that sets the derivation that is wrapped by the module.

#### Suffixes

`optionContents`: Options that *generate* a **file** in the wrapped package's directory from a nix string by copying
its contents verbatim

`optionFile(s)`: Options that *import or symlink* a **file(s)** directly into the wrapped package's $out path

`optionDir`: Options that *import or symlink* a **directory** directly into the wrapped package's $out path

## mkWrapper usage

`mkWrapper` is a convinience function to standardize how derivations are wrapped in `adios-wrappers`, and
is itself a module. It returns a derivation using `stdenvNoCC.mkDerivation`. [Read about stdenv here.](https://ryantm.github.io/nixpkgs/stdenv/stdenv/)

Example usage in a module wrapping a nixpkgs derivation (does not have to be from nixpkgs, just has to be a derivation):

```nix
{ types, ...} @ adios:
{
  inputs.mkWrapper.from = { parent }: parent.mkWrapper;
  inputs.

  options = {
    # Set options to be used in `impl`

    package = {
      type = types.derivation;
      description = "The $program_name to be wrapped"
    };
  };

  impl = { options, inputs }:
    inputs.mkWrapper {
      package = some_derivation;
      
      
    }
}
```

### mkWrapper options

Types use [korora types](https://github.com/adisbladis/korora/)

#### `package`

Type: `derivation`

The package to be wrapped.

#### `name`

Type: `string`

The name of the package to be wrapped.

This determines the pname of the wrapped package, as well as the derivation to be automatically run when using `nix run`.

Defaults to `package.pname`.

#### `extraPaths`

Type: `listOf<derivation>`

Extra derivations which should have their directory structures replicated in the final package.

#### `binaryPath`

Type: `string`

Path within the input derivation to the binary which should be wrapped.

Defaults to `$out/bin/${name}`

#### `preWrap`

Type: `nullOr<String>`

Commands to be run before the wrapping process in the build steps.

#### `postWrap`

Type: `nullOr<String>`

Commands to be run after the wrapping process in the build steps.

#### `wrapperArgs`

Type: `nullOr<String>`

Extra args passed directly to wrapProgram.

#### `environment`

Type: `attrsOf<union<null,pathLike,readFromFileAtRuntime>>`

Environment variables to be set during the execution of the wrapped program.

#### `symlinks`

Type: `attrsOf<nullOr<pathLike>>`

Symlinks to be included in the resulting derivation.
Each key specifies the location within the derivation to create the symlink.
Each value specifies where the symlink should be directed to.

#### `flags`

Type: `listOf<string>`

Flags to be automatically appended to the wrapped program.

## Docs generation

Documentation is generated by `dev/generate-docs.sh` and produces an `options.json` file containing all options from modules in
the `/modules` folder, including their name, description, type and default value.

When PRing changes modifying the `/modules` directory, regenerate the `options.json` file by doing the following:

```
dev/generate-docs.sh > docs/options.json
```

## Formatting

A specific fork of `nixfmt` is used for formatting modules (and other .nix files).

When PRing changes to these files, enter the formatting shell with
```bash
  nix-shell dev/shell.nix
```
and format changed files with
```bash
  nixfmt
```
