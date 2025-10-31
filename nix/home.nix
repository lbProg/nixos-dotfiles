{ config, lib, pkgs, inputs, ...}:

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
    neovim-remote
    librewolf
    hyprsunset
    swaybg
    hypridle
    wayfreeze
    slurp
    grim
    satty
    wl-clipboard
    hyprpicker
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
    initExtra = ''
      source ~/nixos-dotfiles/default/bashrc
    '';
  };

  programs.hyprlock = {
    enable = true;
  };

  services.mako = {
    enable = true;
    extraConfig = builtins.readFile "${config.home.homeDirectory}/nixos-dotfiles/default/mako/core.ini";
  };

  imports = [ inputs.walker.homeManagerModules.default ];
  programs.walker = {
    enable = true;
    runAsService = true;
    config = builtins.fromTOML (builtins.readFile "${dotfiles}/walker/config.toml");

    themes = {
      "nixos-default" = {
        style = builtins.readFile "${config.home.homeDirectory}/nixos-dotfiles/default/walker/themes/nixos-default/style.css";
        layouts = {
          "layout" = builtins.readFile "${config.home.homeDirectory}/nixos-dotfiles/default/walker/themes/nixos-default/layout.xml";
        };
      };
    };
  };

  systemd.user.services.elephant-delayed = {
    Unit = {
      Description = "Delayed restart for Elephant to ensure socket exists";
      After = [ "graphical-session.target" "default.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 5";
      ExecStart = "${pkgs.systemd}/bin/systemctl --user restart elephant";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  services.swayosd.enable = true;

  home.sessionPath = [ "/home/lucien/nixos-dotfiles/bin" ];

  home.file = {
    ".config/kitty".source = "${dotfiles}/kitty";
    ".config/hypr".source = "${dotfiles}/hypr";
    ".config/waybar".source = "${dotfiles}/waybar";
    ".config/btop".source = "${dotfiles}/btop";
    ".config/nvim".source = "${dotfiles}/nvim";
    # ".config/walker/config.toml".source = "${dotfiles}/walker/config.toml";
    ".config/swayosd".source = "${dotfiles}/swayosd";
  };
}
