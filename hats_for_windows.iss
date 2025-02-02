; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
[SETUP]
AppId={{10A741B8-E330-4DC5-A86C-7F7B8DE775A9}
AppName=Purple HATS Desktop
AppVersion=0.9.0
AppVerName=Purple HATS Desktop
AppPublisher=GovTech
AppPublisherURL=https://github.com/GovTechSG/purple-hats-desktop
AppSupportURL=https://github.com/GovTechSG/purple-hats-desktop
AppUpdatesURL=https://github.com/GovTechSG/purple-hats-desktop
DefaultDirName=C:\Program Files\Purple HATS Desktop
DisableDirPage=yes
ChangesAssociations=yes
DisableProgramGroupPage=yes
; LicenseFile=Purple HATS-win32-x64\LICENSE
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "Purple HATS-win32-x64\*"; DestDir: "\\?\{app}\Purple HATS Frontend"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "D:\a\Purple HATS Backend\*"; DestDir: "\\?\{app}\Purple HATS Backend"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\Purple HATS Desktop"; Filename: "{app}\Purple HATS Frontend\Purple HATS.exe"
Name: "{autodesktop}\Purple HATS Desktop"; Filename: "{app}\Purple HATS Frontend\Purple HATS.exe"; Tasks: desktopicon

; [Run]
; Filename: "{app}\Purple HATS Frontend\Purple Hats.exe"; Description: "{cm:LaunchProgram,Purple HATS Desktop}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}\Purple HATS Frontend"
Type: filesandordirs; Name: "{app}\Purple HATS Backend"

[InstallDelete]
Type: filesandordirs; Name: "{app}\Purple HATS Frontend"
Type: filesandordirs; Name: "{app}\Purple HATS Backend"
