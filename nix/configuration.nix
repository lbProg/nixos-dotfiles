{ config, lib, pkgs, ... }:

{
  imports =
    [
      # ./hardware-configuration-vm-laptop-1.nix
      # ./hardware-configuration-vm-desktop.nix
      ./hardware-configuration-grenoble.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "fr";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };
  
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  services.xserver = {
    xkb.layout = "fr";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    #material-design-icons
    #font-awesome
  ];

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  users.users.lucien = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
      kdePackages.falkon
    ];
  };

  environment.variables = {
    TERMINAL = "kitty";
    BROWSER = "librewolf";
    EDITOR = "nvim";
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    kitty
    home-manager
    unzip
    gcc
    nodejs
    brightnessctl
    libxkbcommon # For nixos-menu-keybindings
    jq # Same
    wiremix
    blueberry
  #  swayosd
  ];

  #services.udev.packages = [ pkgs.swayosd ];

  #systemd.services.swayosd-libinput-backend = {
  #  script = ''
  #    ${pkgs.swayosd}/bin/swayosd-libinput-backend
  #  '';

  #  wantedBy = [ "multi-user.target" ];
  #};

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";

}

