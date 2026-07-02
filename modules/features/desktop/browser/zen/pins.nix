{
  flake.homeModules.zenPins =
    let
      teamsUrl = "https://teams.cloud.microsoft/";
      ghUrl = "http://192.168.5.16/ghci/index.php/Authentification";
      todoUrl = "https://docs.google.com/document/d/1b8iTKnk9vJ2XjeNQwDScE9vk9-LYLUUlc8tWWTYrvDA/edit?pli=1&tab=t.0";
      amazonUrl = "https://www.amazon.fr/-/en/ref=nav_logo";
      aliexpressUrl = "https://fr.aliexpress.com/?spm=a2g0o.cart.logo.1.3093378dWtSaQe";
      githubUrl = "https://github.com";
      myNixosUrl = "https://mynixos.com/";
      nixosPackagesUrl = "https://search.nixos.org/packages";
      nixosOptionsUrl = "https://search.nixos.org/options";
      cratesUrl = "https://crates.io/";
      twitchUrl = "https://twitch.com";
      youtubeUrl = "https://youtube.com";
      redditUrl = "https://reddit.com";
      whatsappUrl = "https://web.whatsapp.com/";
      leboncoinUrl = "https://www.leboncoin.fr/";
      jinkaUrl = "https://www.jinka.fr/";
      claudeUrl = "https://claude.ai/new";
      canalUrl = "https://www.canalplus.com/";
      deezerUrl = "https://www.deezer.com/";

      workId = "cdd10fab-4fc5-494b-9041-325e5759195b";
      personalId = "c6de089c-410d-4206-961d-ab11f988d40a";
      shoppingId = "78aabdad-8aae-4fe0-8ff0-2a0c6c4ccc24";
      devId = "78e3bba2-c29a-4573-977e-3477a56b0feb";
      workPins = {
        "Teams" = {
          id = "859d6d24-bb0b-4e3d-b3f6-65d50f135545";
          url = teamsUrl;
          position = 102;
          workspace = workId;
          container = 3;
        };
        "GH" = {
          id = "505ce33f-df2f-4e54-8e1a-5ae0a16365e3";
          url = ghUrl;
          position = 103;
          workspace = workId;
          container = 3;
        };
        "Google Doc" = {
          id = "f2e3d2e1-ff5f-4415-afd9-a637eb1ac81d";
          url = todoUrl;
          position = 104;
          workspace = workId;
          container = 3;
        };
      };
      shoppingPins = {
        "Amazon" = {
          id = "132a4fe7-e488-4a0f-8e86-205cfe717cbf";
          url = amazonUrl;
          position = 101;
          workspace = shoppingId;
          container = 4;
        };
        "Aliexpress" = {
          id = "087edbc8-bad1-4fd3-895e-60c705d74a3f";
          url = aliexpressUrl;
          position = 102;
          workspace = shoppingId;
          container = 4;
        };
        "Leboncoin" = {
          id = "c47a938c-9be2-4b00-9fa7-082d0bd60e96";
          url = leboncoinUrl;
          position = 103;
          workspace = shoppingId;
          container = 4;
        };
      };
      devPins = {
        "GitHub" = {
          id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
          url = githubUrl;
          position = 101;
          workspace = devId;
          container = 2;
        };
        "Claude" = {
          id = "f9848f46-5fee-41e7-a69a-1fa60f24718d";
          url = claudeUrl;
          position = 102;
          workspace = devId;
          container = 2;
        };
        "Nix Tools" = {
          id = "d85a9026-1458-4db6-b115-346746bcc692";
          workspace = devId;
          isGroup = true;
          isFolderCollapsed = false;
          editedTitle = true;
          position = 200;
          container = 2;
        };
        "My NixOS" = {
          id = "28f83a23-2dae-49ec-b6f7-9bfad32bc0ff";
          url = myNixosUrl;
          folderParentId = devPins."Nix Tools".id;
          position = 201;
        };
        "NixOS Packages" = {
          id = "f8dd784e-11d7-430a-8f57-7b05ecdb4c77";
          url = nixosPackagesUrl;
          folderParentId = devPins."Nix Tools".id;
          position = 202;
        };
        "NixOS Options" = {
          id = "92931d60-fd40-4707-9512-a57b1a6a3919";
          url = nixosOptionsUrl;
          folderParentId = devPins."Nix Tools".id;
          position = 203;
        };
        "Rust Tools" = {
          id = "d505971e-0e86-4971-abc2-0c899c2a0178";
          workspace = devId;
          isGroup = true;
          isFolderCollapsed = false;
          editedTitle = true;
          position = 300;
          container = 2;
        };
        "Crates" = {
          id = "9125d300-59f2-4995-a468-eeaf3da07ff8";
          url = cratesUrl;
          folderParentId = devPins."Rust Tools".id;
          position = 301;
        };
      };
      persoPins = {
        "Twitch" = {
          id = "327ca5d6-a577-4390-ad51-ef8947a83d82";
          url = twitchUrl;
          position = 101;
          workspace = personalId;
          container = 1;
        };
        "Youtube" = {
          id = "7db410d2-dcdf-4c34-ba91-2e144093bebe";
          url = youtubeUrl;
          position = 102;
          workspace = personalId;
          container = 1;
        };
        "Canal" = {
          id = "8cf966af-e496-4d5a-b229-aa52f782b6cc";
          url = canalUrl;
          position = 103;
          workspace = personalId;
          container = 1;
        };
        "Reddit" = {
          id = "3b354f4f-2704-4801-8f0a-684f88af8931";
          url = redditUrl;
          position = 104;
          workspace = personalId;
          container = 1;
        };
        "Whatsapp" = {
          id = "3dbc43fc-3d63-48e1-a353-f146de02e7e7";
          url = whatsappUrl;
          position = 105;
          workspace = personalId;
          container = 1;
        };
        "Deezer" = {
          id = "a9bd4fc5-1880-4c9e-9fa7-f333abc554f9";
          url = deezerUrl;
          position = 106;
          workspace = personalId;
          container = 1;
        };
        "Jinka" = {
          id = "ab21c5ca-c393-4f94-b87e-d8c57e445933";
          url = jinkaUrl;
          position = 107;
          workspace = personalId;
          container = 1;
        };
      };
    in
    {
      programs.zen-browser.profiles = {
        default = {
          pinsForce = true; # Delete pins not declared here
          pins = workPins // devPins // persoPins // shoppingPins;
        };
        work = {
          pinsForce = true; # Delete pins not declared here
          pins = workPins;
        };
        perso = {
          pinsForce = true; # Delete pins not declared here
          pins = devPins // persoPins // shoppingPins;
        };
      };
    };
}
