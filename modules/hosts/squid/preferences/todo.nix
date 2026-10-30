{
  flake.homeModules.preferencesTodoSquid =
    { osConfig, ... }:
    let
      sops = osConfig.sops.secrets;
    in
    {
      preferences.todo = {
        server = {
          tokenFile = sops.todoToken.path;
          url = "https://todo.wallago.xyz";
        };
        keys = {
          up = "i";
          down = "e";
          left = "n";
          right = "o";
        };
      };
    };
}
