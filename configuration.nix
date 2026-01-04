# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
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
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [ i3blocks ];
    };
  };

  # touchpad support, laptop only
  services.libinput.enable = true;

  # Set PowerButton behaviour, see `man logind.conf` for options.
  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
  };

  # Allow i3blocks to read hard-coded /etc path
  environment.pathsToLink = [ "/libexec" ];

  # Enable patched dev fonts
  fonts.packages = [ pkgs.nerd-fonts.sauce-code-pro ];

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.michael = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ]; # wheel enables ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  home-manager.users.michael = { pkgs, ... }: {
    home.stateVersion = "25.11";

    home.packages = with pkgs; [
      (catppuccin-kvantum.override {
        accent = "blue";
        variant = "macchiato";
      })
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      papirus-folders
    ];

    gtk = {
      enable = true;
      theme = {
        name = "Breeze-Dark";
        package = pkgs.kdePackages.breeze-gtk;
      };
      iconTheme = {
        name = "Breeze-Dark";
        package = pkgs.kdePackages.breeze-gtk;
      };
      cursorTheme = {
        name = "breeze_cursors";
        package = pkgs.kdePackages.breeze;
      };
      gtk3 = {
        extraConfig.gtk-application-prefer-dark-theme = true;
      };
    };

    home.pointerCursor = {
      gtk.enable = true;
      name = "breeze_cursors";
      package = pkgs.kdePackages.breeze;
      size = 16;
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "Breeze-Dark";
        color-scheme = "prefer-dark";
      };
    };

    # qt = {
    #   enable = true;
    #   platformTheme = "qtct";
    #   style.name = "kvantum";
    # };

    # xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
    #   General.theme = "Catppuccin-Macchiato-Blue";
    # };

    services.udiskie = {
      enable = true;
      settings = {
        # workaround for
        # https://github.com/nix-community/home-manager/issues/632
        program_options = {
            # replace with your favorite file manager
            file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
        };
      };
    };
  };

  # List packages installed in system profile.
  # Most packages can be installed at the user level without a rebuild.
  environment.systemPackages = with pkgs; [
    acpi
    alacritty
    arandr
    feh
    firefox
    gthumb
    helix
    meld
    ntfs3g
    rofi
    sysstat
    units
    unzip
    wget
    wine
    wirelesstools
  ];

  powerManagement.enable = true;

  # Enable udisks, for mounting drives
  services.udisks2.enable = true;

  # Enable docker
  virtualisation.docker.enable = true;

  # Enable kvm utils
  #virtualisation.libvirtd.enable = true;

  # Programs are special packages that need more configuration than simple packages.
  # https://search.nixos.org/options?channel=20.09&from=0&size=50&sort=relevance&query=programs

  programs.git.enable = true;

  # Enable zsh
  programs.zsh.enable = true;

  # Allow programmes to persist their settings
  programs.dconf.enable = true;

  # Games
  #programs.steam.enable = true;

  #nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  #  "steam"
  #  "steam-original"
  #  "steam-runtime"
  #];
  # Steam's DNS is broken, so ping media.steampowered.com, and put that IP here.
  #networking.extraHosts =
  #''
  #  62.24.251.18 client-download.steampowered.com
  #'';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
