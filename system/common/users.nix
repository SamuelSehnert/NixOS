{ config, lib, pkgs, ... }@extras: {
  users.mutableUsers = true;
  users.users =
    let
      default = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
      };
    in
    builtins.listToAttrs (
      builtins.map
        (name: {
          inherit name;
          value = default;
        })
        extras.machine.usernames
    );
}
