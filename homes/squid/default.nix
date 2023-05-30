{ config, pkgs, ... }: let
    username = config.username;
    homeDirectory = "/home/${username}";
in {
    home = {
        inherit username homeDirectory;
        stateVersion = "22.11";
        packages = with pkgs; [
            preconfigured  # Neovim-flake neovim
            firefox
        ];

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
        ./foot.nix
        ./sway.nix
    ];
}
