{
  services.couchdb = {
    enable = true;
    extraConfig = ''
      [httpd]
      enable_cors = true
      [cors]
      origins = app://obsidian.md,capacitor://localhost,http://localhost
      credentials = true
      methods = GET, PUT, POST, HEAD, DELETE
      headers = accept, authorization, content-type, origin, referer
    '';
  };
}
