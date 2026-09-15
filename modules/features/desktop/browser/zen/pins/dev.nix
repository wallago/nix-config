{ self, ... }: {
  flake.homeModules.zenPinsDev =
    {
      mkGroup,
      ...
    }:
    let
      id = "78e3bba2-c29a-4573-977e-3477a56b0feb";
      pins =
        mkGroup {
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
          name = "Tools";
          id = "02339c42-3291-44f3-997d-fc1fe174f69f";
          workspace = id;
          container = 2;
          position = 500;
        } self.lib.zen.sites.dev.tools
        // mkGroup {
          name = "Self";
          id = "c61f1889-e9af-46fd-9aeb-e16a624d997a";
          workspace = id;
          container = 2;
          position = 600;
        } self.lib.zen.sites.dev.self
        // mkGroup {
          name = "Lib";
          id = "4ee8a3e6-3df2-4688-a4b0-0a3d06eb2ffa";
          workspace = id;
          container = 2;
          position = 700;
        } self.lib.zen.sites.dev.lib
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
          inherit pins;
        };
      };
    };
}
