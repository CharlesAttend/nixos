{ appimageTools, fetchurl, lib }:
let
  pname = "sunsama";
  version = "3.4.6";

  src = fetchurl {
    url = "https://desktop.sunsama.com/linux/appImage/x64";
    hash = "sha256-r6Hp4PFK5iqaC/tC4cG29FZC8BdHcm2/F/9AMqxDbYQ=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
    postExtract = ''
      substituteInPlace $out/sunsama.desktop \
        --replace-fail 'Exec=AppRun' 'Exec=env DESKTOPINTEGRATION=false sunsama %u'
    '';
  };
in
appimageTools.wrapAppImage {
  inherit pname version;

  src = appimageContents;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/sunsama.desktop \
      $out/share/applications/sunsama.desktop

    cp -a ${appimageContents}/usr/share/icons $out/share/icons
  '';

  passthru.src = src;

  meta = {
    description = "The daily planner for elite professionals";
    homepage = "https://sunsama.com/";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = "sunsama";
  };
}
