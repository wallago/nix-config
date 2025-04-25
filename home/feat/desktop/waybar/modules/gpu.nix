{ mkScript, ... }: {
  interval = 5;
  exec = mkScript {
    script =
      "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits -i 0";
  };
  format = "󰒋  {}%";
}
