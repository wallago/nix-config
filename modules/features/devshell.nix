{ inputs, ... }:
{
  perSystem =
    {
      pkgs,
      system,
      lib,
      ...
    }:
    let
      banner = pkgs.writeShellApplication {
        name = "project-banner";
        runtimeInputs = with pkgs; [
          gum
          jq
          git
          coreutils
          findutils
        ];
        text = ''
          export CLICOLOR_FORCE=1
          cd "$(git rev-parse --show-toplevel)"

          created=$(git log --reverse --format=%as | sed -n 1p)
          updated=$(git log -1 --format=%cr)
          commits=$(git rev-list --count HEAD)
          nixpkgs=$(date -d @"$(jq -r .nodes.nixpkgs.locked.lastModified flake.lock)" +%F)
          hosts=$(cd modules/hosts && printf '%s\n' * | xargs -n 3)

          title=$(gum style --foreground 111 --bold 'nix-config')
          desc=$(gum style --foreground 244 --italic 'NixOS configuration for multi hosts')
          keys=$(gum style --foreground 80 --align right --padding "0 2 0 0" \
            created updated commits nixpkgs hosts)
          vals=$(gum style --foreground 255 \
            "$created" "$updated" "$commits" "$nixpkgs" "$hosts")

          header=$(gum join --vertical --align center "$title" "" "$desc")

          body=$(gum join --vertical --align center \
            "$header" "" "$(gum join --horizontal "$keys" "$vals")")

          gum style --border double --border-foreground 111 \
            --margin "1 2" --padding "1 4" "$body"
        '';
      };
    in
    {
      devShells.default = pkgs.mkShell {
        PROJECT_BANNER = lib.getExe banner;
        packages = with pkgs; [
          just

          inputs.claude-code.packages.${system}.default
          nodejs # deps of claude

          # repo tooling
          typos
          committed
          git-cliff
          lychee

          # nix tooling
          nixfmt
          statix
          deadnix
          manix
          sops
        ];
      };
    };
}
