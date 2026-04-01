inputs: { config, pkgs, ... }:

{
  home.username = "ekkirami";
  home.homeDirectory = "/home/ekkirami";
  
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.packages = with pkgs; [
    # 系统信息和终端
    fastfetch
    nnn
    alacritty

    # 压缩工具
    zip
    xz
    unzip
    p7zip

    # 实用工具
    ripgrep
    jq
    yq-go
    eza
    fzf
    python3

    # 网络工具
    mtr
    iperf3
    dnsutils
    ldns
    aria2
    socat
    nmap
    ipcalc

    # 杂项工具
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # Nix 相关
    nix-output-monitor

    # 生产力工具
    hugo
    glow

    # 系统监控
    btop
    iotop
    iftop

    # 系统调用追踪
    strace
    ltrace
    lsof

    # 系统工具
    sysstat
    lm_sensors
    ethtool
    pciutils
    usbutils
    niri
  ];

  programs.git = {
    enable = true;
    userName = "Ekkirami";
    userEmail = "ekkirami@gmail.com";
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      zstyle :compinstall filename '/home/ekkirami/.zshrc'
      autoload -Uz compinit
      compinit
    '';
    shellAliases = {
      vim = "nvim";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };

  programs.noctalia-shell = {
    enable = true;
    settings = {
      # configure noctalia here
      bar = {
        density = "compact";
        position = "right";
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
          ];
          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];
          right = [
            {
              alwaysShowPercentage = false;
              id = "Battery";
              warningThreshold = 30;
            }
            {
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };
      colorSchemes.predefinedScheme = "Monochrome";
      general = {
        radiusRatio = 0.2;
      };
      location = {
        monthBeforeDay = true;
        name = "Shanghai, China";
      };
    };
    # this may also be a string or a path to a JSON file.
  };

  home.stateVersion = "25.11";
}
