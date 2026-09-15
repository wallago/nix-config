{ self, ... }: {
  flake.homeModules.zenPinsDev =
    {
      mkPins,
      mkGroup,
      ...
    }:
    let
      id = "78e3bba2-c29a-4573-977e-3477a56b0feb";
      pins =
        mkPins {
          workspace = id;
          container = 2;
        } self.lib.zen.sites.dev.default
        // mkGroup {
          name = "Nix Tools";
          id = "d85a9026-1458-4db6-b115-346746bcc692";
          workspace = id;
          container = 2;
          position = 200;
        } self.lib.zen.sites.dev.nix
        // mkGroup {
          name = "Rust Tools";
          id = "d505971e-0e86-4971-abc2-0c899c2a0178";
          workspace = id;
          container = 2;
          position = 300;
        } self.lib.zen.sites.dev.rust
        // mkGroup {
          name = "AI Tools";
          id = "9ccab017-4d67-4409-8dc0-20cc0bcf95bf";
          workspace = id;
          container = 2;
          position = 400;
        } self.lib.zen.sites.dev.ai;
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
