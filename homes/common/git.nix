{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "SamuelSehnert";
    userEmail = "Samuel.Sehnert@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
