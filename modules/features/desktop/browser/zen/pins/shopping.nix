{
  flake.homeModules.zenPinsShopping =
    { mkPins, ... }:
    let
      id = "78aabdad-8aae-4fe0-8ff0-2a0c6c4ccc24";
      pins =
        mkPins
          {
            workspace = id;
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
    in
    {
      programs.zen-browser.profiles = {
        secondary = {
          pinsForce = true; # Delete pins not declared here
          pins = pins;
        };
      };
    };
}
