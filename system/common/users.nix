{ config, lib, pkgs, ... }@extras: {
  users.mutableUsers = false;
  users.users =
    let
      default = name: {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        hashedPassword = extras.secrets.users.${name}.hashedPassword;
      };
    in
    builtins.listToAttrs (
      builtins.map
        (name: {
          inherit name;
          value = default name;
        })
        extras.machine.usernames
    );
}
