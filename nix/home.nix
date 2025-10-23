{ config, lib, pkgs, ...}:

let
  dotfiles = config.lib.file.mkOutOfStoreSymlink "/home/lucien/nixos-dotfiles/config";
in

{
  home.username = "lucien";
  home.homeDirectory = "/home/lucien";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    btop
    nixpkgs-fmt
    waybar
  ];

  programs.git = {
    enable = true;
    userName = "Lucien";
    userEmail = "lucien.bastin@protonmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.neovim = {
    enable = true;
  };

  programs.bash = {
    enable = true;
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec uwsm start -S hyprland-uwsm.desktop
      fi
    '';
  };

  # gtk.cursorTheme.Package = pkgs.bibata-cursors;
  # gtk.cursorTheme.Name = "Bibata-Modern-Ice";

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  home.sessionPath = [ "/home/lucien/nixos-dotfiles/bin" ];

  home.file = {
    ".config/kitty".source = "${dotfiles}/kitty";
    ".config/hypr".source = "${dotfiles}/hypr";
    ".config/waybar".source = "${dotfiles}/waybar";
  };
}
