{ config, pkgs, ... }:

{
  imports = [ ];

  boot.loader.grub.device = "/dev/sdX";  # Replace /dev/sdX with your actual disk

  fileSystems."/" =
    { device = "/dev/sdX1";  # Replace /dev/sdX1 with your actual partition
      fsType = "ext4";
    };

  swapDevices = [ ];

  networking.hostName = "nixos";
  networking.useDHCP = true;

  time.timeZone = "UTC";

  environment.systemPackages = with pkgs; [
    vim
    hyperland
    waybar
  ];

  services.openssh.enable = true;

  users.users.root.initialPassword = "your-password";

  # NVIDIA drivers
  hardware.nvidia = {
    modesetting.enable = true;
    package = pkgs.nvidiaPackages.stable;
  };

  # Enable graphical interface
  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

  # Enable Hyperland and Waybar
  services.hyperland.enable = true;

  # Additional configuration for Hyperland
  programs.hyperland = {
    enable = true;
    config = {
      compositor = {
        enable = true;
        options = {
          backend = "drm";
          vsync = true;
        };
      };
    };
  };

  # Waybar configuration
  services.waybar.enable = true;

  # Enable hardware acceleration and NVIDIA drivers
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    videoDrivers = [ "nvidia" ];
  };
}
