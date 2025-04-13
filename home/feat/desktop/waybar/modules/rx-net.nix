{ mkScript, ... }:
{
  format = "{icon} {}";
  format-icons = {
    default = "";
  };
  return-type = "json";
  tooltip = false;
  interval = 1;
  exec = mkScriptJson {
    script = ''
      INTERFACE=$(ip route get 1.1.1.1 | grep -oP 'dev\s+\K[^ ]+')
      NET_RX1=$(ifstat -j | jq ".kernel.$INTERFACE.rx_bytes")
      sleep 1
      NET_RX2=$(ifstat -j | jq ".kernel.$INTERFACE.rx_bytes")
      NET_RX=$((NET_RX2 - NET_RX1))
      if [ $NET_RX -ge 1073741824 ]; then
        RATE=$(echo "scale=2; $NET_RX / 1073741824" | bc)
        UNIT="GB/s"
      elif [ $NET_RX -ge 1048576 ]; then
        RATE=$(echo "scale=2; $NET_RX / 1048576" | bc)
        UNIT="MB/s"
      elif [ $NET_RX -ge 1024 ]; then
        RATE=$(echo "scale=2; $NET_RX / 1024" | bc)
        UNIT="KB/s"
      else
        RATE=$NET_RX
        UNIT="B/s"
      fi
      echo "{\"text\": \"$RATE $UNIT\"}"
    '';
  };
  exec-if = mkScriptJson {
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
