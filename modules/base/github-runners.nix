{
  flake.nixosModules.githubRunnersOptions =
    { lib, ... }:
    {
      options.preferences.github.runners = lib.mkOption {
        type = lib.types.attrsOf (
          lib.types.submodule {
            options = {
              tokenFile = lib.mkOption {
                type = lib.types.str;
                description = "Token file path";
              };
              url = lib.mkOption {
                type = lib.types.str;
                description = "Repository address";
              };
            };
          }
        );
        default = { };
        description = "Github runners";
      };
    };
}
