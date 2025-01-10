{
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    extraConfig.pipewire = {
      context.properties = {
        default.clock.rate = 48000;
        #defautlt.allowed-rates = [ 192000 48000 44100 ];
        defautlt.allowed-rates = [ 48000 ];
        default.clock.quantum = 2048;
        default.clock.min-quantum = 1024;
        #default.clock.max-quantum = 32;
      };
    };

    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    wireplumber.extraConfig = {
      "override.monitor.bluez.properties" = {
        "bluez5.enable-msbc" = false;
        "bluez5.hfphsp-backend" = "none";
        "bluez5.a2dp.ldac.quality" = "mq";
        "api.alsa.headroom" = 1024;
        "bluez5.a2dp.aac.bitratemode" = 1;
        "bluez5.roles" = [
          "a2dp_sink"
          "a2dp_source"
        ];
        "10-disable-camera" = {
          "wireplumber.profiles" = {
            main."monitor.libcamera" = "disabled";
          };
        };
      };
    };
  };
}
