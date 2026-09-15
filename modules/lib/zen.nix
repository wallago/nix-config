{
  flake.lib.zen.sites = {
    work = [
      # Work
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
    shopping = [
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
    perso = {
      entertainment = [
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
      ];
      social = [
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
      ];
      misc = [
        {
          name = "Jinka";
          id = "ab21c5ca-c393-4f94-b87e-d8c57e445933";
          url = "https://www.jinka.fr/";
        }
      ];
    };
    dev = {
      default = [
        {
          name = "GitHub";
          id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
          url = "https://github.com";
        }
      ];
      nix = [
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
      ];
      rust = [
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
      ];
      ai = [
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
      tools = [
        {
          name = "Cloudflare";
          id = "ff84a63f-a537-4676-9a48-41eddc54fe1c";
          url = "https://dash.cloudflare.com/bfdb3ee6d1ba5f748e3d64cee32abf50/wallago.xyz/ssl-tls/origin/origin-certificates";
        }
        {
          name = "Codecov";
          id = "85fbc7ff-8b37-4bd6-bf3d-e5a3809dcf4e";
          url = "https://app.codecov.io/gh/wallago";
        }
      ];
      self = [
        {
          name = "RSS (miniflux)";
          id = "624c0f42-bf16-4cb3-ad57-96d6a0a1aa0f";
          url = "https://rss.wallago.xyz";
        }
        {
          name = "Sync (syncthing)";
          id = "23bd1ad9-d9c1-4856-9e2f-f857d181a53b";
          url = "https://sync.wallago.xyz";
        }
      ];
    };
  };
}
