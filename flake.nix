{
  inputs.adios.url = "github:llakala/adios"; # My personal fork

  outputs = inputs: {
    wrapperModules = import ./default.nix {
      adios = inputs.adios;
    };
  };
}
