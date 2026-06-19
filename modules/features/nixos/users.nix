{self, ...}: {
  flake.nixosModules.users = {
    config,
    pkgs,
    ...
  }:
    let
      username = config.var.username;
      password = config.var.password;
      sshAuthKey = config.var.sshAuthKey;
    in {
      programs.zsh.enable = true;

      users = {
        defaultUserShell = pkgs.zsh;
        users.${username} = {
          isNormalUser = true;
          description = "${username} account";
          extraGroups = ["networkmanager" "wheel" "video" "audio"];
          hashedPassword = password;
          openssh.authorizedKeys.keys = [sshAuthKey];
        };
      };
    };
}
