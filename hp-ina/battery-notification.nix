{ config, pkgs, ... }:

{
  systemd.user.services."battery-low" = {
    enable = true;
    description = "Notify user if battery is below 30%";
    partOf = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = pkgs.writeShellScript "battery-low-notification" ''
        bat=/sys/class/power_supply/BAT0
        status="$(cat "$bat"/status)"
        level="$(cat "$bat"/capacity)"
        if [[ "$status" == "Discharging" ]] && (( level <= 30 ));
        then ${pkgs.lib.getExe pkgs.libnotify} --urgency=critical "low battery" "$level%";
        fi
      '';
    };
  };
  systemd.user.timers."battery-low" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # Every Minute
      OnCalendar = "*-*-* *:*:00";
      Unit = "battery-low.service";
    };
  };
}
