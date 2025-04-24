{
  interval = 3;
  format-wifi = "   {essid}";
  format-ethernet = "󰈁 Connected";
  format-disconnected = "";
  tooltip-format = ''
    {ifname}
    {ipaddr}/{cidr}
    Up: {bandwidthUpBits}
    Down: {bandwidthDownBits}'';
}
