{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # 代理设置
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.hostName = "Rami-Nix";
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  time.timeZone = "Asia/Shanghai";

  # i18n.defaultLocale = "zh_CN.UTF-8";
  # i18n.extraLocaleSettings = {
  #   LC_ADDRESS = "zh_CN.UTF-8";
  #   LC_IDENTIFICATION = "zh_CN.UTF-8";
  #   LC_MEASUREMENT = "zh_CN.UTF-8";
  #   LC_MONETARY = "zh_CN.UTF-8";
  #   LC_NAME = "zh_CN.UTF-8";
  #   LC_NUMERIC = "zh_CN.UTF-8";
  #   LC_PAPER = "zh_CN.UTF-8";
  #   LC_TELEPHONY = "zh_CN.UTF-8";
  #   LC_TIME = "zh_CN.UTF-8";
  # };

  # services.xserver.xkb = {
  #   layout = "cn";
  #   variant = "";
  # };

  users.users.ekkirami = {
    isNormalUser = true;
    description = "Ekkirami";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.substituters = lib.mkForce [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    neovim
    openssh
    axel
    btop
    tree
    zsh
    curl
    htop
    tmux
  ];
  environment.variables.EDITOR = "nvim";
  programs.zsh.enable = true;

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };

  services.xserver.enable = true;  # 启用X11窗口系统
  services.desktopManager.gnome.enable = true;  # 启用GNOME桌面环境
  services.displayManager.gdm.enable = true;  # 启用GDM显示管理器（GNOME登录界面）
  services.xserver.xkb.layout = "us";  # 设置X11键盘布局为美式
  programs.niri.enable = true;  # 启用Niri Wayland合成器（作为GNOME的替代或补充）
  programs.firefox.enable = true;  # 启用Firefox浏览器

  services.pulseaudio.enable = false;  # 禁用PulseAudio（使用PipeWire替代）
  security.rtkit.enable = true;  # 启用RTKit实时内核支持（用于音频权限）
  services.pipewire = {
    enable = true;  # 启用PipeWire多媒体框架
    alsa.enable = true;  # 启用PipeWire的ALSA兼容层
    alsa.support32Bit = true;  # 支持32位ALSA应用
    pulse.enable = true;  # 启用PulseAudio兼容层
  };

  networking.firewall.enable = false;

  system.stateVersion = "25.11";
}
