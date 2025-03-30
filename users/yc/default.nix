{ ... }:
let
  username = "yc";
in
{

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ];
    password = "${username}";
  };

  home-manager.users.${username} = ../../home/common {
    inherit
      username
      inputs
      outputs
      ;
  };
}
