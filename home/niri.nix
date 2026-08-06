{
  pkgs,
  inputs,
  home-manager,
  lib,
  config,
  ...
}: {
  programs.noctalia.enable = true;

  programs.niri = {
    settings = {
      environment = {
        GDK_BACKEND = "wayland";
        XDG_SESSION_TYPE = "wayland";
        QT_QPA_PLATFORM = "wayland";
      };
      input = {
        keyboard.xkb = {
          layout = "us";
          options = "compose:ralt";
        };
        mouse = {
          natural-scroll = false;
          accel-speed = 0.1;
          accel-profile = "adaptive";
        };
        trackball = {
          natural-scroll = false;
          accel-speed = 0.7;
          accel-profile = "adaptive";
        };
      };
      binds = {
        "Mod+T".action.spawn = ["wezterm"];
        "Mod+R".action.spawn = [
          "noctalia-ipc"
          "launcher toggle"
        ];
        "Mod+Shift+Slash".action.show-hotkey-overlay = [];
        "XF86AudioLowerVolume".action.spawn = [
          "noctalia-ipc"
          "call"
          "volume"
          "decrease"
        ];
        "XF86AudioRaiseVolume".action.spawn = [
          "noctalia-ipc"
          "call"
          "volume"
          "increase"
        ];
        "XF86AudioMute".action.spawn = [
          "noctalia-ipc"
          "call"
          "volume"
          "muteOutput"
        ];
        "XF86MonBrightnessDown".action.spawn = [
          "noctalia-ipc"
          "call"
          "brightness"
          "decrease"
        ];
        "XF86MonBrightnessUp".action.spawn = [
          "noctalia-ipc"
          "call"
          "brightness"
          "increase"
        ];
      };
      spawn-at-startup = [
        {
          command = [
            "mako"
            "noctalia-shell"
          ];
        }
      ];
    };
  };
  home.packages = with pkgs; [
    alacritty
    mako
    swaybg
    swaylock
    swayidle
    xdg-desktop-portal-gnome
    gnome-keyring
    xwayland-satellite
  ];
}
