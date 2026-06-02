{
  flake.nixosModules.githubRunnersOptions =
    { lib, ... }:
    {
      options.preferences.github.runners = {
        type = lib.types.attrsOf (
          lib.types.submodule (
            { name, ... }:
            {
              options = {
                name = lib.mkOption {
                  type = lib.types.str;
                  default = name;
                  description = "Runner name";
                };
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
          )
        );
        default = { };
        description = "Github runners";
      };
    };
}
