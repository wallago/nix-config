{ config, ... }:
let pass = "${config.programs.password-store.package}/bin/pass";
in {
  # NOTE: get gmail tokens 
  # -> into https://console.cloud.google.com/home/dashboard
  # -> creat Desktop App "oama"
  # -> creat OAuth2 "Inbox Assistant"
  # -> pass insert oama/google_client_id
  # -> pass insert oama/google_client_secret
  # For each <email>
  # -> add <email> to https://console.cloud.google.com/auth/audience
  # -> oama authorize google <email>
  # -> oama show <email>
  programs.oama = {
    enable = true;
    settings = {
      encryption.tag = "KEYRING";
      services.google = {
        client_id_cmd = "${pass} oama/google_client_id | head -1";
        client_secret_cmd = "${pass} oama/google_client_secret | head -1";
        auth_scope = "https://mail.google.com/";
      };
    };
  };
}
