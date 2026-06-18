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
      programs.zen-browser.profiles = {
        default.extensions.packages = commonAddons;
        work.extensions.packages = commonAddons;
        perso.extensions.packages = commonAddons;
      };
    };
}
