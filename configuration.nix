# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true; # Use NetworkManager, not wpa_supplicant

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  # computer specific interfaces go here

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    keyMap = "uk";
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Set up Xorg and I3
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    libinput.enable = true; # touchpad support, laptop only
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [ i3blocks ];
    };
  };

  # Allow i3blocks to read hard-coded /etc path
  environment.pathsToLink = [ "/libexec" ];

  # Enable patched dev fonts
  fonts.fonts = with pkgs; [ nerdfonts ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.michael = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ]; # wheel enables ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. 
  # Most packages can be installed at the user level without a rebuild.
  environment.systemPackages = with pkgs; [
    ntfs3g
  ];

  # Enable docker
  virtualisation.docker.enable = true;

  # Programs are special packages that need more configuration than simple packages.
  # https://search.nixos.org/options?channel=20.09&from=0&size=50&sort=relevance&query=programs
  # Enable zsh
  programs.zsh.enable = true;
  
  # Allow programmes to persist their settings
  programs.dconf.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}

