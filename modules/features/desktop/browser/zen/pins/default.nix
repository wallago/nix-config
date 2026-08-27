{ self, ... }: {
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
    in
    {
      _module.args = {
        inherit mkPins mkGroup;
      };

      imports = [
        self.homeModules.zenPinsDev
        self.homeModules.zenPinsShopping
        self.homeModules.zenPinsPerso
        self.homeModules.zenPinsWork

      ];
    };
}
