# User and Host Configuration

## User: ${user}

### Host: ${host}
- **Operating System**: NixOS
- **Host Type**: Desktop/Laptop/Server
- **Hardware Details**:
  - CPU: Intel i7
  - RAM: 16GB
  - Disk: 512GB SSD
  - GPU: NVIDIA GTX 1080
  
### NixOS Configuration:
- **NixOS Version**: 23.05
- **NixOS Configuration**: 
  - Disk setup with `Disko`
  - Custom networking (e.g., Tailscale)
  - Firewall setup
  - System optimizations
- **NixOS Host**: Defined in `hosts/${host}.nix`

---

## User-specific Configuration

### User: ${user}

- **Home Directory**: `/home/${user}`
- **Home Manager Configuration**:
  - Shell: Fish
  - Terminal: Alacritty
  - Text Editor: Neovim
  - Browser: Qutebrowser
  - Email Client: Neomutt
- **User-specific NixOS Configuration**: Defined in `home/${user}/${host}/config.nix`

