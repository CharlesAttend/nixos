{ appimageTools, fetchurl, lib }:
let
  pname = "notion-electron";
  version = "2.0.0";

  src = fetchurl {
    url = "https://github.com/anechunaev/notion-electron/releases/download/v${version}/Notion_Electron-${version}-x86_64.AppImage";
    hash = "sha256-AKDQ4/j+PianpK+9pXYEVaRXReiQFYgTLvSmcKD5f1M=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
    postExtract = ''
      substituteInPlace $out/notion-electron.desktop \
        --replace-fail 'Exec=AppRun' 'Exec=notion-electron'
    '';
  };
in
appimageTools.wrapAppImage {
  inherit pname version;

  src = appimageContents;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/notion-electron.desktop \
      $out/share/applications/notion-electron.desktop

    cp -a ${appimageContents}/usr/share/icons $out/share/icons
  '';

  passthru.src = src;

  meta = {
    description = "Unofficial Notion desktop client for Linux";
    homepage = "https://github.com/anechunaev/notion-electron";
    changelog = "https://github.com/anechunaev/notion-electron/releases/tag/v${version}";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    mainProgram = "notion-electron";
  };
}
