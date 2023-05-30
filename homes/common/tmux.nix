{ config, pkgs, ... }: {
    programs.tmux = {
        enable = true;
        mouse = true;
        baseIndex = 1;
        keyMode = "vi";
        clock24 = false;
        sensibleOnTop = true;
        shell = "${pkgs.fish}/bin/fish";

        extraConfig = ''
            bind '"' split-window -v -c "#{pane_current_path}"
            bind % split-window -h -c "#{pane_current_path}"
        '';

        plugins = with pkgs.tmuxPlugins; [
            resurrect
        ];
    };
}
