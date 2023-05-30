{ config, pkgs, ... }: {
    programs.foot = {
        enable = true;
        settings = {
            main = {
                shell = "${pkgs.fish}/bin/fish";
                font = "monospace:size=10";
            };
        };
    };
}
