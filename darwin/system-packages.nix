{ pkgs, lib, inputs, ... }: {
  environment.systemPackages =
    [
      pkgs.vim
      pkgs.openssh
      pkgs.yubikey-manager
      #pkgs.libfido2            # Is this needed for yubikey SSH?
    ];
}
