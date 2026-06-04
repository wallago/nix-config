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
              extraPackages = lib.mkOption {
                type = lib.types.listOf lib.types.package;
                default = [ ];
                description = "Extra packages to add to the runner's PATH";
              };
            };
          }
        );
        default = { };
        description = "Github runners";
      };
    };
}
