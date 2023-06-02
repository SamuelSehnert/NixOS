{ config, pkgs, username, importList, packages, ... }:
let
  homeDirectory = "/home/${username}";
in
{
  home = {
    inherit username homeDirectory packages;
    stateVersion = "22.11";
    sessionVariables = {
      SHELL = "${pkgs.fish}/bin/fish";
      EDITOR = "${pkgs.preconfigured}/bin/nvim";
    };
  };

  xdg = {
    configHome = "/home/${username}/.config";
    cacheHome = "/home/${username}/.cache";
    stateHome = "/home/${username}/.local/state";
    dataHome = "/home/${username}/.local/share";
  };

  imports = [
    ../common/fish.nix
    ../common/git.nix
    ../common/tmux.nix
  ] ++ importList;
}
