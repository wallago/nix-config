{ inputs, ... }:
{
  flake.homeModules.zenExtensions =
    { pkgs, ... }:
    let
      firefox-addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};
      commonAddons = with firefox-addons; [
        ublock-origin
        dearrow
        vimium
        bitwarden
      ];

    in
    {
      programs.zen-browser.profiles.default.extensions.packages = commonAddons;
      programs.zen-browser.profiles.work.extensions.packages = commonAddons;
      programs.zen-browser.profiles.perso.extensions.packages = commonAddons;
    };
}
