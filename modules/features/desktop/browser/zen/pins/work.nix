{ self, ... }: {
  flake.homeModules.zenPinsWork =
    { mkPins, ... }:
    let
      id = "cdd10fab-4fc5-494b-9041-325e5759195b";
      pins = mkPins {
        workspace = id;
        container = 3;
        start = 102;
      } self.lib.zen.sites.work;
    in
    {
      programs.zen-browser.profiles = {
        default = {
          pinsForce = true; # Delete pins not declared here
          pins = pins;
        };
      };
    };
}
