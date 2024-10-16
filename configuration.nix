{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };
   services.xserver.enable = true;
   services.xserver.displayManager.sddm.enable = true;
   services.xserver.displayManager.sddm.wayland.enable = true;

  console.keyMap = "uk";

  users.users.nuks = {
    isNormalUser = true;
    description = "Nuksil";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    htop
    git
    waybar
  ];

  system.stateVersion = "24.05";

  # Hyprland Configuration
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Session Variables for Wayland and Electron
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1"; # If your cursor becomes invisible
    NIXOS_OZONE_WL = "1"; # Hint Electron apps to use Wayland
  };

  # Hardware settings
  hardware.opengl.enable = true;  # Enable OpenGL
  hardware.nvidia.modesetting.enable = true;  # Most Wayland compositors need

  # XDG Portals for better desktop integration
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Enable sound with PipeWire and related services
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };


}
