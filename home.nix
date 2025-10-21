{ config, pkgs, ...}:

{
  home.username = "lucien";
  home.homeDirectory = "/home/lucien";
  home.stateVersion = "25.05";
  
  programs.git = {
    enable = true;
    userName = "Lucien";
    userEmail = "lucien.bastin@protonmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline ];
  };

  programs.bash = {
    enable = true;
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec uwsm start -S hyprland-uwsm.desktop
      fi
    '';
  };

  home.file.".config/kitty".source = ./config/kitty;
  home.file.".config/hypr".source = ./config/hypr;
}
