{ pkgs, userinfo, ... }:
let
  # On macOS, nixpkgs builds git without sysconfdir=/etc, so it never reads
  # /etc/gitconfig on its own. This wrapper points git's system-level config
  # at /etc/gitconfig (managed below). Users can still override any setting
  # in ~/.gitconfig or ~/.config/git/config.
  git = pkgs.symlinkJoin {
    name = "git-${pkgs.git.version}";
    paths = [ pkgs.git ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/git --set-default GIT_CONFIG_SYSTEM /etc/gitconfig
    '';
  };
in
{
  environment.systemPackages = [ git ];

  environment.etc."gitconfig".text = ''
    [user]
    	name = ${userinfo.fullname}
    	email = ${userinfo.email}
  '';
}
