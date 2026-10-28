{ userinfo, ... }: {
  home-manager.useGlobalPkgs   = true;
  home-manager.useUserPackages = true;

  home-manager.users.${userinfo.username} = { pkgs, ... }: {
    home.username      = userinfo.username;
    home.homeDirectory = "/Users/${userinfo.username}";
    home.stateVersion  = "26.05";
    programs.git = {
      enable = true;
      settings.user = {
        name = "${userinfo.fullname}";
        email = "${userinfo.email}";
      };
    };
    programs.lazygit.enable = true;
  };
}
