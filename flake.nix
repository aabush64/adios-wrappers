{
  inputs.adios.url = "github:llakala/lladios"; # My personal fork

  # Evil disgusting personal repo shit
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = inputs: let
    nixpkgs = inputs.nixpkgs;
    forAllSystems = function:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
      ] (system: function nixpkgs.legacyPackages.${system});
  in rec
  {
    wrapperModules = import ./default.nix {
      adios = inputs.adios.adios;
    };

    wrappers = forAllSystems (pkgs:
      import ./wrappedmodules/default.nix {
        inherit pkgs;
        adios = inputs.adios.adios;
        adios-wrappers = wrapperModules;
      });

    devShells = forAllSystems (
      pkgs: let
        wrappers = inputs.self.wrappers.${pkgs.stdenv.hostPlatform.system};
      in {
        default = pkgs.mkShellNoCC {
          name = "adios-wrappers";
          allowSubstitutes = false;
          packages = [
            wrappers.eza
            # wrappers.fish
            # wrappers.starship
            # wrappers.wezterm
            # wrappers.dunst
            # wrappers.dunst
            
          ];
          shellHook = ''
            # wezterm start --class "weztest" 
          '';
        };
      }
    );
  };
}
