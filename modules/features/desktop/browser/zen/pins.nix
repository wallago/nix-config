{
  flake.homeModules.zenPins =
    { lib, ... }:
    let
      # Stamp shared workspace/container onto flat pins; number from `start`.
      mkPins =
        {
          workspace,
          container,
          start ? 101,
        }:
        pins:
        lib.listToAttrs (
          lib.imap0 (
            i: p:
            lib.nameValuePair p.name {
              inherit (p) id url;
              inherit workspace container;
              position = start + i;
            }
          ) pins
        );

      # A collapsible folder plus its child pins (numbered from position + 1).
      mkGroup =
        {
          id,
          name,
          workspace,
          container,
          position,
        }:
        children:
        {
          ${name} = {
            inherit
              id
              workspace
              container
              position
              ;
            isGroup = true;
            isFolderCollapsed = false;
            editedTitle = true;
          };
        }
        // lib.listToAttrs (
          lib.imap1 (
            i: c:
            lib.nameValuePair c.name {
              inherit (c) id url;
              folderParentId = id;
              position = position + i;
            }
          ) children
        );

      workId = "cdd10fab-4fc5-494b-9041-325e5759195b";
      personalId = "c6de089c-410d-4206-961d-ab11f988d40a";
      shoppingId = "78aabdad-8aae-4fe0-8ff0-2a0c6c4ccc24";
      devId = "78e3bba2-c29a-4573-977e-3477a56b0feb";

      workPins =
        mkPins
          {
            workspace = workId;
            container = 3;
            start = 102;
          }
          [
            {
              name = "Teams";
              id = "859d6d24-bb0b-4e3d-b3f6-65d50f135545";
              url = "https://teams.cloud.microsoft/";
            }
            {
              name = "GH";
              id = "505ce33f-df2f-4e54-8e1a-5ae0a16365e3";
              url = "http://192.168.5.16/ghci/index.php/Authentification";
            }
            {
              name = "Google Doc";
              id = "f2e3d2e1-ff5f-4415-afd9-a637eb1ac81d";
              url = "https://docs.google.com/document/d/1b8iTKnk9vJ2XjeNQwDScE9vk9-LYLUUlc8tWWTYrvDA/edit?pli=1&tab=t.0";
            }
          ];

      shoppingPins =
        mkPins
          {
            workspace = shoppingId;
            container = 4;
          }
          [
            {
              name = "Amazon";
              id = "132a4fe7-e488-4a0f-8e86-205cfe717cbf";
              url = "https://www.amazon.fr/-/en/ref=nav_logo";
            }
            {
              name = "Aliexpress";
              id = "087edbc8-bad1-4fd3-895e-60c705d74a3f";
              url = "https://fr.aliexpress.com/?spm=a2g0o.cart.logo.1.3093378dWtSaQe";
            }
            {
              name = "Leboncoin";
              id = "c47a938c-9be2-4b00-9fa7-082d0bd60e96";
              url = "https://www.leboncoin.fr/";
            }
          ];

      persoPins =
        mkPins
          {
            workspace = personalId;
            container = 1;
          }
          [
          ]
        //
          mkGroup
            {
              name = "Entertainment";
              id = "56b387a8-d3cf-409a-961d-3b550be46ca7";
              workspace = personalId;
              container = 1;
              position = 200;
            }
            [
              {
                name = "Twitch";
                id = "327ca5d6-a577-4390-ad51-ef8947a83d82";
                url = "https://twitch.com";
              }
              {
                name = "Youtube";
                id = "7db410d2-dcdf-4c34-ba91-2e144093bebe";
                url = "https://youtube.com";
              }
              {
                name = "Canal";
                id = "8cf966af-e496-4d5a-b229-aa52f782b6cc";
                url = "https://www.canalplus.com/";
              }
              {
                name = "Deezer";
                id = "a9bd4fc5-1880-4c9e-9fa7-f333abc554f9";
                url = "https://www.deezer.com/";
              }
            ]
        //
          mkGroup
            {
              name = "Social Network";
              id = "a59977b2-91b6-46e3-89a1-8848481b55b8";
              workspace = personalId;
              container = 1;
              position = 300;
            }
            [
              {
                name = "Reddit";
                id = "3b354f4f-2704-4801-8f0a-684f88af8931";
                url = "https://reddit.com";
              }
              {
                name = "Whatsapp";
                id = "3dbc43fc-3d63-48e1-a353-f146de02e7e7";
                url = "https://web.whatsapp.com/";
              }
            ]
        //
          mkGroup
            {
              name = "Misc";
              id = "4f2fc00a-bd41-4b8b-bc3e-772b22e06317";
              workspace = personalId;
              container = 1;
              position = 400;
            }
            [
              {
                name = "Jinka";
                id = "ab21c5ca-c393-4f94-b87e-d8c57e445933";
                url = "https://www.jinka.fr/";
              }
            ];

      devPins =
        mkPins
          {
            workspace = devId;
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
              workspace = devId;
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
              workspace = devId;
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
              workspace = devId;
              container = 2;
              position = 400;
            }
            [
              {
                name = "Claude";
                id = "f9848f46-5fee-41e7-a69a-1fa60f24718d";
                url = "https://claude.ai/new";
              }
            ];
    in
    {
      programs.zen-browser.profiles = {
        default = {
          pinsForce = true; # Delete pins not declared here
          pins = workPins // devPins;
        };
        secondary = {
          pinsForce = true; # Delete pins not declared here
          pins = persoPins // shoppingPins;
        };
      };
    };
}
