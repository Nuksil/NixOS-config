{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda2"; # or the correct device for your system

  networking.hostName = "NuksNix"; # Set your hostname
  networking.useDHCP = true; # or configure a static IP

  time.timeZone = "Europe/London"; # Set your timezone

  # Enable X server
  services.xserver.enable = true;
  services.xserver.layout = "uk"; # Set your keyboard layout
  services.xserver.displayManager.lightdm.enable = true; # Use LightDM as the display manager
  services.xserver.desktopManager.xterm.enable = false; # Disable Xterm
  services.xserver.windowManager.i3.enable = true; # Enable i3 window manager

  # Enable Waybar
  services.waybar.enable = true;

  environment.systemPackages = with pkgs; [
    vim # or your preferred text editor
    hyper # Install Hyper terminal
    waybar # Install Waybar
    i3status # Status bar for i3
  ];

  # Enable SSH service
  services.openssh.enable = true;

  users.users.your_username = { # Replace 'your_username' with your actual username
    isNormalUser = true;
    initialPassword = "Glider007"; # Set a password
    extraGroups = [ "wheel" ]; # Add user to the wheel group for sudo access
  };

  # Allow members of the wheel group to use sudo
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false; # Optional: allow passwordless sudo for wheel group

  system.stateVersion = "22.11"; # Set to the version of NixOS you are installing
}
