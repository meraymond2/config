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
  # Disable this in favour of NetworkManager
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  #networking.interfaces.enp0s20f0u1.useDHCP = true;
  networking.interfaces.wlp1s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
  #   font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     acpi # battery monitor
     alacritty
     bc
     breeze-gtk
     cinnamon.nemo
     exfat
     feh
     firefox 
     git
     kitty
     meld
     moc
     networkmanagerapplet
     ntfs3g
     rofi
     sysstat # cpu monitor
     udiskie
     unzip
     vlc
   ];
   
  fonts.fonts = with pkgs; [
    nerdfonts
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  # Required for Firefox
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        #i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
      ];
    };
    
    # Enable touchpad support.
	libinput.enable = true;
  };
  
  # Allow i3blocks to read hard-coded /etc path
  environment.pathsToLink = [ "/libexec" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.michael = {
    isNormalUser = true;
    extraGroups = [ 
        "networkmanager" # Allow user to change network settings.
        "wheel" # Enable `sudo` for the user.
    ];
    shell = pkgs.zsh;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

  # Enable zsh
  programs.zsh.enable = true;
  
  # Allow programmes to persist their settings
  programs.dconf.enable = true;
}

