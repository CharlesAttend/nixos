{ appimageTools, fetchurl, lib}:
let
  pname = "trustbuilder";
  version = "6.38.0.5319";

  src = fetchurl {
    url = "https://download.trustbuilder.com/wp-content/uploads/Authenticator6-Linux.AppImage";
    hash = "sha256-4FeW6N3PByr8owPrAikxUQtZ3emubmToEsutjMxYTHM=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
    postExtract = ''
      # Adjust .desktop so it works outside of the AppImage container
      substituteInPlace $out/"authenticator 6.desktop" \
        --replace-fail 'Exec=AppRun' 'Exec=trustbuilder %U'
    '';
  };
in
appimageTools.wrapAppImage {
  inherit pname version;

  src = appimageContents;

  # The bundled Electron is too old for Wayland: with GDK_BACKEND unset GDK
  # fails to get a display and the app dies with
  # "Gtk-WARNING: cannot open display: :1". Force the X11 (Xwayland) backend.
  profile = ''
    export GDK_BACKEND=x11
  '';

  # bwrap does not expose the host /etc inside the FHS env, so `--chdir "$(pwd)"`
  # aborts when the app is launched from anywhere under /etc (e.g. /etc/nixos).
  chdirToPwd = false;

  extraInstallCommands = ''
    install -m 444 -D "${appimageContents}/authenticator 6.desktop" \
      $out/share/applications/trustbuilder.desktop

    install -m 444 -D "${appimageContents}/usr/share/icons/hicolor/0x0/apps/authenticator 6.png" \
      $out/share/icons/trustbuilder.png
  '';

  # Carry the original src for nix-update
  passthru.src = src;

  meta = {
    description = "Trustbuilder Authenticator";
    homepage = "https://www.trustbuilder.com/";
    license = lib.licenses.gpl1Only; # adjust if the actual license differs
    platforms = [ "x86_64-linux" ];
    mainProgram = "trustbuilder";
  };
}
