
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "NukNix";

  # Enable networking
  networking.networkmanager.enable = true;
  
  # Bluetooth enable
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nuks = {
    isNormalUser = true;
    description = "nuksil";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
  
  # Black sereen fix
  environment.sessionVariables = {
    WLR_NO_HARDWARE_COURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  # Opengl enable
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  
  };
  
  # hyprland enable
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
 
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git  
    vscode
    waybar
    dunst
    kitty
    rofi-wayland
    libnotify 
    swww
    google-chrome
    vscode
    neovim
    networkmanagerapplet
    dolphin 
  ];


  # List services that you want to enable:
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.modesetting.enable = true;
  

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Desktop portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  
  # Sound enable
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };


  system.stateVersion = "24.05"; 

}
