{
  # Griffon client network, run by Headscale on coral. Replaces the
  # hand-written wg1 peer list: machines join with a pre-auth key, and the
  # ACL below is the same for every client, so a new client never needs a
  # coral redeploy.
  flake.lib.headscale = {
    url = "vpn.wallago.xyz";

    # MagicDNS suffix, e.g. 4835-corolla.griffon.internal. Must not be a
    # parent of `url`.
    baseDomain = "griffon.internal";

    # Untagged nodes owned by this user are the admins (squid, sponge).
    user = "wallago";

    # Every client machine joins as tag:griffon. Admins may open these
    # ports on it; clients may open nothing, so they can't see each other.
    clientPorts = [
      2201
      2202
      2203
      2222
      443
      3000
    ];

    # The provisioning ISO joins as tag:provision (ephemeral) and only
    # exposes its SSH port.
    provisionPorts = [ 2222 ];
  };
}
