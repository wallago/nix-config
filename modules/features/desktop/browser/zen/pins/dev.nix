{
  flake.homeModules.zenPinsDev =
    { mkPins, mkGroup, ... }:
    let
      id = "78e3bba2-c29a-4573-977e-3477a56b0feb";
      pins =
        mkPins
          {
            workspace = id;
            container = 2;
          }
          [
            {
              name = "GitHub";
              id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
              url = "https://github.com";
            }
          ]
        //
          mkGroup
            {
              name = "Nix Tools";
              id = "d85a9026-1458-4db6-b115-346746bcc692";
              workspace = id;
              container = 2;
              position = 200;
            }
            [
              {
                name = "My NixOS";
                id = "28f83a23-2dae-49ec-b6f7-9bfad32bc0ff";
                url = "https://mynixos.com/";
              }
              {
                name = "NixOS Packages";
                id = "f8dd784e-11d7-430a-8f57-7b05ecdb4c77";
                url = "https://search.nixos.org/packages";
              }
              {
                name = "NixOS Options";
                id = "92931d60-fd40-4707-9512-a57b1a6a3919";
                url = "https://search.nixos.org/options";
              }
            ]
        //
          mkGroup
            {
              name = "Rust Tools";
              id = "d505971e-0e86-4971-abc2-0c899c2a0178";
              workspace = id;
              container = 2;
              position = 300;
            }
            [
              {
                name = "Crates";
                id = "9125d300-59f2-4995-a468-eeaf3da07ff8";
                url = "https://crates.io/";
              }
              {
                name = "Cheats";
                id = "c10a4d86-c164-4f62-a9d5-bff31562a78d";
                url = "https://cheats.rs/";
              }
            ]
        //
          mkGroup
            {
              name = "AI Tools";
              id = "9ccab017-4d67-4409-8dc0-20cc0bcf95bf";
              workspace = id;
              container = 2;
              position = 400;
            }
            [
              {
                name = "Claude";
                id = "f9848f46-5fee-41e7-a69a-1fa60f24718d";
                url = "https://claude.ai/new";
              }
              {
                name = "Claude Console";
                id = "2abfe3aa-e620-466d-af18-2bb3536704f1";
                url = "https://platform.claude.com/dashboard";
              }
              {
                name = "Chatgpt";
                id = "053ee344-e733-4628-9325-7d7e76c6c896";
                url = "https://chatgpt.com/";
              }
            ];
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
