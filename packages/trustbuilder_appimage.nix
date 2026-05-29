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
