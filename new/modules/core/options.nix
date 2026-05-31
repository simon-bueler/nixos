{lib, ...}: {
  options.flake = {
    homeModules = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.unspecified;
      default = {};
    };
    darwinConfigurations = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.unspecified;
      default = {};
    };
    diskoConfigurations = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.unspecified;
      default = {};
    };
  };

  config.flake.nixosModules.coreOptions = {
    options = {
      var = lib.mkOption {
        type = lib.types.attrs;
        default = {};
      };
    };
  };
}
