{ pkgs, self, lib, inputs, ...}:
{
  imports = [
    ./hardware-configuration.nix
    #"./niri.nix";
    #"./noctalia.nix";
    #"./shell.nix";
    inputs.niri.nixosModules.niri
  ];
  #networking.hostName = "nixWork";
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.displayManager.defaultSession = "plasma";
  
  services.xserver.displayManager = {
  lightdm = {
    enable = true;
    greeters.slick.enable = true;
  };
  };
  services.desktopManager.plasma6.enable = true; 

  # Hardware basics setup
  hardware = {
    bluetooth.enable = true;
    graphics.enable = true;
    graphics.enable32Bit = true;
  };
  services = {
    blueman.enable = true;
    flatpak.enable = true;
    fprintd.enable = true;
    power-profiles-daemon.enable = true;
    upower.enable = true;
  };

  
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "trantor"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  systemd.services.NetworkManager-wait-online.enable = false;
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  nixpkgs.overlays = [ inputs.niri.overlays.niri inputs.emacs-overlay.overlays.default ];
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
  niri-flake.cache.enable = true;
  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };
  programs.xwayland.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  services.ratbagd.enable = true;
  


  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.fish.enable = true;
  users.users.mjolnir = {
      isNormalUser = true;
      extraGroups = [ "wheel" "video" "audio" "networkmanager" ]; # Enable ‘sudo’ for the user.
      shell = pkgs.fish;
  };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
     bitwarden-desktop
     _1password-gui
     firefox
     git
     # Editors
     vim 
     helix
     kakoune
     findutils
     ((emacsPackagesFor pkgs.emacs).emacsWithPackages (
      epkgs: with epkgs; [
        vterm
        pdf-tools
        emacsql
      ]
     ))
     # Terminal
     ghostty
     wezterm
     alejandra
     bat
     fd 
     fish
     piper
     home-manager
     maple-mono.NF
     nushell
     protonvpn-gui
     jujutsu
     direnv
     nix-direnv
     # Chat Apps
     vesktop
     signal-desktop
     element
     schildi-revenge
     #Nix
     nixd
  #   wget
  # Sort mess out here.
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
    };
    #package = pkgs.nixFlakes;
    extraOptions = " experimental-features = nix-command flakes ";
    optimise.automatic = true;
    settings.auto-optimise-store = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
