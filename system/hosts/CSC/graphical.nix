{ config, lib, pkgs, ... }: {
    services.xserver = {
        enable = true;
        libinput.enable = true;
        excludePackages = [
            pkgs.xterm
        ];
        displayManager = {
            sessionPackages = [ pkgs.gnome.gnome-session.sessions ];
            gdm = {
                enable = true;
                wayland = true;
            };
        };  
        desktopManager.gnome.enable = true;
    };
    documentation.doc.enable = false;
    environment.gnome.excludePackages = (with pkgs; [
        gnome-photos
        gnome-tour
        gnome-connections
        gnome-text-editor
        gnome-console
        gnome-extension-manager
    ]) ++ (with pkgs.gnome; [
        eog
        cheese
        gnome-music
        gnome-terminal
        gedit
        epiphany
        geary
        evince
        gnome-characters
        totem
        tali
        iagno
        hitori
        atomix
        gnome-shell-extensions
        gnome-calculator
        gnome-clocks
        gnome-contacts
        simple-scan
        yelp
        gnome-maps
        gnome-weather
        gnome-system-monitor
        file-roller
        gnome-logs
        gnome-font-viewer
        gnome-calendar
    ]);

    services.avahi.enable = false;
    services.gnome.gnome-browser-connector.enable = false;

    programs = {
        sway.enable = true;
    };
}
