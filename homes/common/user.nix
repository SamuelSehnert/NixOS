{ config
, pkgs
, username
, importList
, userPackages
, ...
}:
let
  homeDirectory = "/home/${username}";
  commonPackages = (import ./pkgs.nix) { inherit config pkgs; };
in
{
  home = {
    inherit username homeDirectory;
    stateVersion = "22.11";
    sessionVariables = {
      SHELL = "${pkgs.fish}/bin/fish";
      EDITOR = "${pkgs.preconfigured}/bin/nvim";
    };
    packages = userPackages ++ commonPackages;
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
