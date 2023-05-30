{ config, lib, pkgs, ... }: {
    services = {
        upower.enable = true;
        # Gnome gets angry at this being true
        # tlp.enable = true;
        logind = {
            lidSwitch = "hybrid-sleep";
        };
    };
}
