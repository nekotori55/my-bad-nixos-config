{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.modules.vpn.enable {
    environment.systemPackages = [ pkgs.nekoray ];

    security.polkit.enable = true;
    security.polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
      if (
        action.id == "org.freedesktop.policykit.exec" &&
        (action.lookup("command_line").indexOf(' /home/' + subject.user + '/.config/nekoray/config/vpn-run-root.sh') !== -1)
        )
        {
        return polkit.Result.YES;
        }
      });
    '';
  };
}
