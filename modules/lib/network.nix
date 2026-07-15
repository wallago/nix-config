{

  flake.lib.networks = {
    wg0 = {
      port = 51820;
      hosts = {
        coral = {
          ip = "10.100.0.1";
          publicKey = "FoiHQJLNM4aCmuvf2g2Mb6wqe8kU00AqWd7hGvNLZzY=";
        };
        squid = {
          ip = "10.100.0.2";
          publicKey = "CeGKBz6Xtuj/UaZqUc8u9/fQ53IH3L9uS+X8XRflj24=";
        };
        sponge = {
          ip = "10.100.0.3";
          publicKey = "GHHvXL/R+e/7ofeO01PC5reIrY0W7recbK2KzBjnaXg=";
        };
        cuttlefish = {
          ip = "10.100.0.4";
          publicKey = "Bx8RvmvK2EpC41zqscX4zuw+qjYYWrPB3LrUxk8xg3k=";
        };
        krill = {
          ip = "10.100.0.5";
          publicKey = "b0TYc2kWNyWNv2HcXAv4FfF0ZKPotvoVz33gKmJuyTA=";
        };
        worm = {
          ip = "10.100.0.6";
          publicKey = "JTl7tlUtS6mKNwjJ0oGXT68XxJ7U8mQ+wb6m5sXxdT8=";
        };
        anemone = {
          ip = "10.100.0.7";
          publicKey = "HXIP0qGJzsnjF47rEQ0usHWLFjPuXl4BvATJbJVktlY=";
        };
      };
    };
    wg1 = {
      port = 51840;
      hosts = {
        coral = {
          ip = "10.200.0.1";
          publicKey = "VwQJyFAj9053C6dT6zB/JZ9kBZ/wma1b+xfpB+eCRXs=";
        };
        squid = {
          ip = "10.200.0.2";
          publicKey = "XOr3H2ae1jdm+k2TzkSArirfa57DSpM3wTEXrvLkzBg=";
        };
        sponge = {
          ip = "10.200.0.3";
          publicKey = "OJYAx4VxGWMc73S0EModA/A8tRYYrdAq+lQnlPHNmgE=";
        };
        "4778" = {
          ip = "10.200.0.4";
          publicKey = "i1PhzPWel1imDtTxqM+16ScqDgBAw+/AFXTLNA3h+G8=";
        };
        "4839" = {
          ip = "10.200.0.5";
          publicKey = "dMpVKFGflmX9QzrBaCPa5Z2WUqJ1hC7QuvtFmq4w1lM=";
        };
        "4797" = {
          ip = "10.200.0.6";
          publicKey = "p99A09tn8LOAJsAVPldf6+ZMmmOutYuph5LbB7akBFQ=";
        };
        "4849" = {
          ip = "10.200.0.7";
          publicKey = "AZgGljiVN/i4xZ2XWbqqsjbACHzX+HF6vurYFuRq9wA=";
        };
        provision-iso = {
          ip = "10.200.0.254";
          publicKey = "Qfc0+PXgYKb7BnVFXObFRtsJT6lFXfhTzl6JDIJtVw4=";
        };
      };
    };
  };
}
