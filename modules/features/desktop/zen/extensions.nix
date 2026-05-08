{ inputs, ... }:
{
  flake.homeModules.zenExtensions =
    { pkgs, ... }:
    let
      firefox-addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      programs.zen-browser.profiles.default.extensions.packages = with firefox-addons; [
        ublock-origin
        dearrow
        proton-pass
        vimium
      ];
    };
}
