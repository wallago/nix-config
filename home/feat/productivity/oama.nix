{ config, ... }:
let pass = "${config.programs.password-store.package}/bin/pass";
in {
  # NOTE: get gmail tokens 
  # -> into https://console.cloud.google.com/home/dashboard
  # -> creat Desktop App "oama"
  # -> creat OAuth2 "Inbox Assistant"
  # -> add email to https://console.cloud.google.com/auth/audience
  # -> oama authorize google <email>
  # -> pass insert oama/google_client_id
  # -> pass insert oama/google_client_secret
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
