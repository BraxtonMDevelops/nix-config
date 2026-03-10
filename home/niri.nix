{pkgs, inputs, home-manager, lib, config, ...}:

let
  noctalia = cmd: [
    "noctalia-shell" "ipc" "call"
  ] ++ (lib.splitString " " cmd);
in
{
   imports = [
     inputs.noctalia.homeModules.default
     inputs.niri.homeModules.niri
   ];

   programs.noctalia-shell.enable = true;
    
   programs.niri = {
     enable = true;
     package = pkgs.niri-stable;
     settings = {
	binds = with config.lib.niri.actions; { 
          "Mod+T".action.spawn = "ghostty";
          "Mod+Space".action.spawn = noctalia "launcher toggle"; 
        };
	spawn-at-startup = [{
	  command = [
	    "mako" 
	    "noctalia-shell" 
	  ];
        }];
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
   ];
	

}
