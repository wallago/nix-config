let
  userOptions =
    { lib, ... }:
    {
      options.preferences.user.name = lib.mkOption {
        type = lib.types.str;
        default = "wallago";
      };
    };
in
{
  flake.nixosModules.optionUser = userOptions;
  flake.homeModules.optionUser = userOptions;
}
