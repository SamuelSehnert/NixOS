{ config, pkgs, ... }: {
    wayland.windowManager.sway = {
        enable = true;

        config.bars = [{
            # statusCommand = "${config.programs.waybar.package}/bin/waybar";
            command = "${config.programs.waybar.package}/bin/waybar";
        }];
    };

    programs.waybar = {
        enable = true;
        systemd.enable = true;
        settings = [{
            layer = "top";
            position = "top";
            height = 50;
            output = [
                "eDP-1"
                "HDMI-A-1"
            ];
            modules-left = [ "sway/workspaces" "sway/mode" "wlr/taskbar" ];
            modules-center = [ "sway/window" "custom/hello-from-waybar" ];
            modules-right = [ "mpd" "custom/mymodule#with-css-id" "temperature" ];

            "sway/workspaces" = {
                disable-scroll = true;
                all-outputs = true;
            };
            "custom/hello-from-waybar" = {
                format = "hello {}";
                max-length = 40;
                interval = "once";
                exec = pkgs.writeShellScript "hello-from-waybar" ''
                    echo "from within waybar"
                '';
            };
        }];
        style = "";
    };

    programs.i3status-rust = {
        enable = true;
        bars = {
        };
    };
}
