{ lib, pkgs, ... }:
{
  services.mediamtx = {
    enable = true;
    settings = {
      paths = {
        cam = {
          runOnInit = "\${lib.getExe pkgs.ffmpeg} -f v4l2 -i /dev/video0 -f rtsp rtsp://localhost:$RTSP_PORT/$RTSP_PATH";
          runOnInitRestart = true;
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8854 ];
}
