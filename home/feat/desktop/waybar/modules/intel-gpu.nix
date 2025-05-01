{ pkgs, mkScript, ... }: {
  interval = 1;
  exec-if = mkScript {
    deps = [ pkgs.intel-gpu-tools ];
    script =
      "intel_gpu_top -l 1 | awk 'NF && $1 ~ /^[0-9]/ {print $0; exit}' | awk '{print $7}'";
  };
}
