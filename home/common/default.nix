{
  username,
  lib,
  pkgs,
  outputs,
  ...
}:
{
  imports = [
    # inputs.stylix.nixosModules.stylix
    ./nix.nix
    (import ./home.nix { inherit username; })
    ../feat/cli

    ./nvim # -------> Vim text editor fork focused on extensibility and agility
    ./zellij.nix # -> Terminal workspace with batteries included
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  # ---

  # stylix = {
  #   enable = true;
  #   image = pkgs.fetchurl {
  #     url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
  #     sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
  #   };
  #   base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  #   polarity = "dark";
  # };
  # ---

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  systemd.user.startServices = "sd-switch";
}
