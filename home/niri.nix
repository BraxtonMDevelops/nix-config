{pkgs, inputs, home-manager, lib, config, ...}:

let
  noctalia = cmd: [
    "noctalia-shell" "ipc" "call"
  ] ++ (lib.splitString " " cmd);
{
   imports = [
     inputs.noctalia.homeModules.default
     inputs.niri-flake.homeModules.niri
   ];

   programs.noctalia-shell.enable = true;
    
   programs.niri = {
     enable = true;
     package = pkgs.niri-stable;
     settings.binds = "Mod+T".action.spawn = "ghostty"; 
     settings.binds = with config.lib.niri.actions {"Mod+Space".action.spawn = noctalia "launcher toggle"; };
     settings.spawn-at-startup = [ { command = [ "noctalia-shell" ]; }];
     settings.spawn-at-startup = [ { command = [ "mako" ]; }];
   };
   home.packages = with pkgs; [
     alacritty
     mako
     swaybg
     swaylock
     swayidle
     xdg-desktop-portal-gnome
     gnome-keyring
   ];
	

}
