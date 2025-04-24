{ mkScript, ... }:
{
  format = "{icon} {}";
  format-icons = {
    default = "";
  };
  return-type = "json";
  tooltip = false;
  interval = 1;
  exec = mkScript {
    script = ''
      INTERFACE=$(ip route get 1.1.1.1 | grep -oP 'dev\s+\K[^ ]+')
      NET_TX1=$(ifstat -j | jq ".kernel.$INTERFACE.tx_bytes")
      sleep 1
      NET_TX2=$(ifstat -j | jq ".kernel.$INTERFACE.tx_bytes")
      NET_TX=$((NET_TX2 - NET_TX1))
      if [ $NET_TX -ge 1073741824 ]; then
        RATE=$(echo "scale=2; $NET_TX / 1073741824" | bc)
        UNIT="GB/s"
      elif [ $NET_TX -ge 1048576 ]; then
        RATE=$(echo "scale=2; $NET_TX / 1048576" | bc)
        UNIT="MB/s"
      elif [ $NET_TX -ge 1024 ]; then
        RATE=$(echo "scale=2; $NET_TX / 1024" | bc)
        UNIT="KB/s"
      else
        RATE=$NET_TX
        UNIT="B/s"
      fi
      echo "{\"text\": \"$RATE $UNIT\"}"
    '';
  };
  exec-if = mkScript {
    script = ''
      INTERFACE_COUNT=$(ip route get 1.1.1.1 | grep -oP 'dev\s+\K[^ ]+' | wc -l)
      if [[ $INTERFACE_COUNT -gt 0 ]]; then
        exit 0
      else
        exit 1
      fi
    '';
  };
}
