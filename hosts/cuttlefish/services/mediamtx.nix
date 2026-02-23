{ lib, pkgs, ... }:
{
  services.mediamtx = {
    allowVideoAccess = true;
    enable = true;
    settings = {
      webrtc = true;
      webrtcAddress = ":8889";
      paths = {
        cam = {
          runOnInit = "${lib.getExe pkgs.ffmpeg} -f v4l2 -input_format mjpeg -video_size 1280x720 -framerate 30 -i /dev/video0 -c:v libx264 -preset ultrafast -tune zerolatency -pix_fmt yuv420p -g 60 -f rtsp rtsp://localhost:$RTSP_PORT/$RTSP_PATH";
          runOnInitRestart = true;
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    8554
    8889
  ];
  networking.firewall.allowedUDPPorts = [
    8189
  ];
}
