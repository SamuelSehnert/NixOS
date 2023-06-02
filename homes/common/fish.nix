{ config, pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAbbrs = {
      sudo = "doas";
      vi = "nvim";
      vim = "nvim";
    };
  };
}
