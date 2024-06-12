[Setup]
AppName=SolScape Launcher
AppPublisher=SolScape
UninstallDisplayName=SolScape
AppVersion=${project.version}
AppSupportURL=https://SolScape.net/
DefaultDirName={localappdata}\SolScape

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=arm64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/app_small.bmp
WizardImageFile=${basedir}/left.bmp
SetupIconFile=${basedir}/app.ico
UninstallDisplayIcon={app}\SolScape.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=SolScapeSetupAArch64

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\build\win-aarch64\SolScape.exe"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\SolScape.jar"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\launcher_aarch64.dll"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\config.json"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs
Source: "${basedir}\app.ico"; DestDir: "{app}"
Source: "${basedir}\left.bmp"; DestDir: "{app}"
Source: "${basedir}\app_small.bmp"; DestDir: "{app}"

[Icons]
; start menu
Name: "{userprograms}\SolScape\SolScape"; Filename: "{app}\SolScape.exe"
Name: "{userprograms}\SolScape\SolScape (configure)"; Filename: "{app}\SolScape.exe"; Parameters: "--configure"
Name: "{userprograms}\SolScape\SolScape (safe mode)"; Filename: "{app}\SolScape.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\SolScape"; Filename: "{app}\SolScape.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\SolScape.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\SolScape.exe"; Description: "&Open SolScape"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\SolScape.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.SolScape\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"