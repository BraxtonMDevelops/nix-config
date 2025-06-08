# Edit this configuration e to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  inputs,
  niri,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./nixos/gaming.nix
  ];

  #services.emacs.enable = true;
  # Use the GRUB boot loader.
  # Additionally this is setup to allow us to detect WinDDOS installs...
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };
  systemd.services.NetworkManager-wait-online.enable = false;
  services.flatpak.enable = true;

  networking.hostName = "LogiRaptor";
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  #networking.networkmanager.wifi.backend = "iwd";
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
  };
  services.syncthing = {
    enable = true;
    user = "mjolnir";
    dataDir = "/home/mjolnir/";
    configDir = "/home/mjolnir/Documents/.config/syncthing";

  };
  hardware.pulseaudio.enable = false;
  # Set your time zone.
  time.timeZone = "America/New_York";

  # Setup for Bluetooth and other misc. hardware things.
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
  };
  services.blueman.enable = true;
  boot.blacklistedKernelModules = [ "nouveau" ];

  # Enable Xwayland to be able to play modern modded Minecraft.
  programs.xwayland = {
    enable = true;
  };
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  # Linux Kernel setup:

  #Rewritten version of X11 things
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    forceFullCompositionPipeline = true;
  };
  hardware.graphics.enable = true;
  hardware.opengl = {
    enable = true;
    #driSupport = true;
    driSupport32Bit = true;
  };
  services.xserver = {

    #Enable the X11 windowing system and set up Nvidia
    enable = true;
    videoDrivers = [ "nvidia" ];

    #displayManager.gddm.enable = true;

    displayManager.defaultSession = "plasma";
    #desktopManager.gnome.enable = true;
    windowManager.awesome.enable = true;
  };
  services.displayManager.sddm.enable = true;

  services.desktopManager.plasma6.enable = true;
  # Enable sound.
  # sound.enable = true;
  programs.kdeconnect.enable = true;

  programs.fish.enable = true;
  #programs.starship.enable =

  #kserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mjolnir = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "networkmanager"
    ]; # Enable ‘sudo’ for the user.
    initialPassword = "mumstheword";
    shell = pkgs.fish;
  };
  # Use if i want from nixpkgs-f2k overlay
  # awesome-luajit-git awesome-composite-git
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    _1password-gui
    #These 2 pkgs below are for use with niri.
    alacritty
    fuzzel
    # Continue regular packages.
    alejandra
    bat
    clang
    coreutils
    direnv
    discord
    ((emacsPackagesFor pkgs.emacs).emacsWithPackages (
      epkgs: with epkgs; [
        vterm
        pdf-tools
        emacsql
      ]
    ))
    easyeffects
    element-desktop
    eza
    fd
    findutils
    firefox
    ghostty
    git
    gtk4
    helix
    home-manager
    jost
    kitty
    libsForQt5.ark
    libsForQt5.qt5.qtwayland
    lorri
    maple-mono.NF
    mlocate
    neovim
    nerd-fonts.symbols-only
    nix-diff
    nix-direnv
    nix-output-monitor
    nixpkgs-fmt
    #nyxt
    ollama
    onlyoffice-bin
    pavucontrol
    phinger-cursors
    protonvpn-gui
    qbittorrent
    qt6.qtwayland
    recursive
    ripgrep
    nil
    nixfmt-rfc-style
    spotify
    sqlite
    sumneko-lua-language-server
    swaybg
    #symbola
    texlive.combined.scheme-medium
    vesktop
    vlc
    kdePackages.xwaylandvideobridge
    wine
    wev
    wezterm
    #wezterm-git
    wlr-randr
    wl-clipboard
    yt-dlp
  ];

  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  services.emacs.package = pkgs.emacs;
  services.emacs.enable = true;
  services.tailscale.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
  nixpkgs.config.allowUnfree = true;

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
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the
}
