{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "SamuelSehnert";
    userEmail = "Samuel.Sehnert@gmail.com";
    signing = {
      signByDefault = true;
      key = "35253865A24300B65E5D89AE200E22E97BB4865F";
    };
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
