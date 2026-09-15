{ self, ... }: {
  flake.homeModules.zenPinsShopping =
    { mkPins, ... }:
    let
      id = "78aabdad-8aae-4fe0-8ff0-2a0c6c4ccc24";
      pins = mkPins {
        workspace = id;
        container = 4;
      } self.lib.zen.sites.shopping;
    in
    {
      programs.zen-browser.profiles = {
        secondary = {
          pinsForce = true; # Delete pins not declared here
          pins = pins;
        };
      };
    };
}
