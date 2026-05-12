{
  flake.homeModules.zenPins = {
    programs.zen-browser.profiles.default =
      let
        work.id = "cdd10fab-4fc5-494b-9041-325e5759195b";
        personal.id = "c6de089c-410d-4206-961d-ab11f988d40a";
        shopping.id = "78aabdad-8aae-4fe0-8ff0-2a0c6c4ccc24";
        dev.id = "78e3bba2-c29a-4573-977e-3477a56b0feb";
        pins = {
          # Personal
          "Twitch" = {
            id = "327ca5d6-a577-4390-ad51-ef8947a83d82";
            url = "https://twitch.com";
            position = 101;
            workspace = personal.id;
            container = 1;
          };
          "Youtube" = {
            id = "7db410d2-dcdf-4c34-ba91-2e144093bebe";
            url = "https://youtube.com";
            position = 102;
            workspace = personal.id;
            container = 1;
          };
          "Reddit" = {
            id = "3b354f4f-2704-4801-8f0a-684f88af8931";
            url = "https://reddit.com";
            position = 103;
            workspace = personal.id;
            container = 1;
          };
          # Dev
          "GitHub" = {
            id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
            url = "https://github.com";
            position = 101;
            workspace = dev.id;
            container = 2;
          };
          "Nix Tools" = {
            id = "d85a9026-1458-4db6-b115-346746bcc692";
            workspace = dev.id;
            isGroup = true;
            isFolderCollapsed = false;
            editedTitle = true;
            position = 200;
            container = 2;
          };
          "My NixOS" = {
            id = "28f83a23-2dae-49ec-b6f7-9bfad32bc0ff";
            url = "https://mynixos.com/";
            folderParentId = pins."Nix Tools".id;
            position = 201;
          };
          "NixOS Packages" = {
            id = "f8dd784e-11d7-430a-8f57-7b05ecdb4c77";
            url = "https://search.nixos.org/packages";
            folderParentId = pins."Nix Tools".id;
            position = 202;
          };
          "NixOS Options" = {
            id = "92931d60-fd40-4707-9512-a57b1a6a3919";
            url = "https://search.nixos.org/options";
            folderParentId = pins."Nix Tools".id;
            position = 203;
          };
          "Rust Tools" = {
            id = "d505971e-0e86-4971-abc2-0c899c2a0178";
            workspace = dev.id;
            isGroup = true;
            isFolderCollapsed = false;
            editedTitle = true;
            position = 300;
            container = 2;
          };
          "Crates" = {
            id = "9125d300-59f2-4995-a468-eeaf3da07ff8";
            url = "https://crates.io/";
            folderParentId = pins."Rust Tools".id;
            position = 301;
          };
          # Work
          "Email" = {
            id = "9d8a8f91-7e29-4688-ae2e-da4e49d4a179";
            url = "https://outlook.office.com/mail/?deeplink=mail%2F&login_hint=O.CiQ0NGVmYmEzMy0yZmNmLTQ4OGEtOTZlMi1mMjVkMDIwMjI3M2MSJDBjMTZiOGFjLWE2YTMtNDk0Yy05NGJkLWJhZWIwNjc4MjdkNBohaHVnby5oZW5yb3R0ZUBkZXNpZ24tc29sdXRpb25zLmZyIOoB";
            position = 101;
            workspace = work.id;
            container = 3;
          };
          "Teams" = {
            id = "859d6d24-bb0b-4e3d-b3f6-65d50f135545";
            url = "https://teams.cloud.microsoft/";
            position = 102;
            workspace = work.id;
            container = 3;
          };
          "GH" = {
            id = "505ce33f-df2f-4e54-8e1a-5ae0a16365e3";
            url = "https://192.168.5.16/";
            position = 103;
            workspace = work.id;
            container = 3;
          };
          "Google Doc" = {
            id = "f2e3d2e1-ff5f-4415-afd9-a637eb1ac81d";
            url = "https://docs.google.com/document/d/1b8iTKnk9vJ2XjeNQwDScE9vk9-LYLUUlc8tWWTYrvDA/edit?pli=1&tab=t.0";
            position = 104;
            workspace = work.id;
            container = 3;
          };
          # Shopping
          "Amazon" = {
            id = "132a4fe7-e488-4a0f-8e86-205cfe717cbf";
            url = "https://www.amazon.fr/-/en/ref=nav_logo";
            position = 101;
            workspace = shopping.id;
            container = 4;
          };
          "Aliexpress" = {
            id = "087edbc8-bad1-4fd3-895e-60c705d74a3f";
            url = "https://fr.aliexpress.com/?spm=a2g0o.cart.logo.1.3093378dWtSaQe";
            position = 102;
            workspace = shopping.id;
            container = 4;
          };
        };
      in
      {
        pinsForce = true; # Delete pins not declared here
        inherit pins;
      };
  };
}
