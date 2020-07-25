!define PRODUCT_NAME "Manim"
!define PRODUCT_VERSION "1.0"
!define PY_VERSION "3.7.3"
!define PY_MAJOR_VERSION "3.7"
!define BITNESS "32"
!define ARCH_TAG ""
!define INSTALLER_NAME "Manim_1.0x86.exe"
!define PRODUCT_ICON "logo.ico"
!define PYVER "3.8.3"
!define ARCH_VERSION ".x86"

; Marker file to tell the uninstaller that it's a user installation
!define USER_INSTALL_MARKER _user_install_marker

SetCompressor lzma

!if "${NSIS_PACKEDVERSION}" >= 0x03000000
  Unicode true
  ManifestDPIAware true
!endif

!define MULTIUSER_EXECUTIONLEVEL Highest
!define MULTIUSER_INSTALLMODE_DEFAULT_CURRENTUSER
!define MULTIUSER_MUI
!define MULTIUSER_INSTALLMODE_COMMANDLINE
!define MULTIUSER_INSTALLMODE_INSTDIR "Manim"
!include MultiUser.nsh
!include FileFunc.nsh

; Modern UI installer stuff
!include "MUI2.nsh"
!define MUI_ABORTWARNING
!define MUI_ICON "logo.ico"
!define MUI_UNICON "logo.ico"

; UI pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE LICENSE.community
!insertmacro MULTIUSER_PAGE_INSTALLMODE
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "English"

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "${INSTALLER_NAME}"
ShowInstDetails show

Var cmdLineInstallDir

Section -SETTINGS
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
SectionEnd


Section "!${PRODUCT_NAME}" sec_app
  SetRegView 32
  SectionIn RO
  File ${PRODUCT_ICON}
  SetOutPath "$INSTDIR\python.${PYVER}${ARCH_VERSION}"
  File /r "python.${PYVER}${ARCH_VERSION}\*.*"


  ; Marker file for per-user install
  StrCmp $MultiUser.InstallMode CurrentUser 0 +3
    FileOpen $0 "$INSTDIR\${USER_INSTALL_MARKER}" w
    FileClose $0
    SetFileAttributes "$INSTDIR\${USER_INSTALL_MARKER}" HIDDEN

      ; Install files
    SetOutPath "$INSTDIR"
      File "logo.ico"
      File "LICENSE"
      File "_system_path.py"

  ; Install directories
    SetOutPath "$INSTDIR\docs"
    File /r "python.${PYVER}${ARCH_VERSION}\manim\docs\*.*"
    SetOutPath "$INSTDIR\example_scenes"
    File /r "python.${PYVER}${ARCH_VERSION}\manim\example_scenes\*.*"
  SetOutPath "%HOMEDRIVE%\%HOMEPATH%"
    CreateShortCut "$SMPROGRAMS\Manim.lnk" "$INSTDIR\python.${PYVER}${ARCH_VERSION}\python.${PYVER}\tools\pythonw.exe" "$INSTDIR\logo.ico"
  SetOutPath "$INSTDIR"
    DetailPrint "Setting up command-line launchers..."

    StrCmp $MultiUser.InstallMode CurrentUser 0 AddSysPathSystem
      ; Add to PATH for current user
      nsExec::ExecToLog '"$INSTDIR\python.${PYVER}${ARCH_VERSION}\python.${PYVER}\tools\python.exe" -Es "$INSTDIR\_system_path.py" add_user "$INSTDIR\python.${PYVER}${ARCH_VERSION}\python.${PYVER}\tools\Scripts"'
      nsExec::ExecToLog '"$INSTDIR\python.${PYVER}${ARCH_VERSION}\python.${PYVER}\tools\python.exe" -m pip install "$INSTDIR\python.${PYVER}${ARCH_VERSION}\manim"'
      GoTo AddedSysPath
    AddSysPathSystem:
      ; Add to PATH for all users
      nsExec::ExecToLog '"$INSTDIR\python.${PYVER}${ARCH_VERSION}\python.${PYVER}\tools\python" -Es "$INSTDIR\_system_path.py" add "$INSTDIR\python.${PYVER}${ARCH_VERSION}\python.${PYVER}\tools\Scripts"'
      nsExec::ExecToLog '"$INSTDIR\python.${PYVER}${ARCH_VERSION}\python.${PYVER}\tools\python.exe" -m pip install "$INSTDIR\python.${PYVER}${ARCH_VERSION}\manim"'
    AddedSysPath:
  
  WriteUninstaller $INSTDIR\uninstall.exe
  ; Add ourselves to Add/remove programs
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" \
                   "DisplayName" "${PRODUCT_NAME}"
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" \
                   "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" \
                   "InstallLocation" "$INSTDIR"
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" \
                   "DisplayIcon" "$INSTDIR\${PRODUCT_ICON}"
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" \
                   "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegDWORD SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" \
                   "NoModify" 1
  WriteRegDWORD SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" \
                   "NoRepair" 1

  ; Check if we need to reboot
  IfRebootFlag 0 noreboot
    MessageBox MB_YESNO "A reboot is required to finish the installation. Do you wish to reboot now?" \
                /SD IDNO IDNO noreboot
      Reboot
  noreboot:
SectionEnd

Section "Uninstall"
  SetRegView 32
  SetShellVarContext all
  IfFileExists "$INSTDIR\${USER_INSTALL_MARKER}" 0 +3
    SetShellVarContext current
    Delete "$INSTDIR\${USER_INSTALL_MARKER}"

  Delete $INSTDIR\uninstall.exe
  Delete "$INSTDIR\${PRODUCT_ICON}"
  RMDir /r "$INSTDIR\docs"

  ; Remove ourselves from %PATH%
    nsExec::ExecToLog '"$INSTDIR\python.${PYVER}${ARCH_VERSION}\python.${PYVER}\tools\python" -Es "$INSTDIR\_system_path.py" remove "$INSTDIR\python.${PYVER}${ARCH_VERSION}\python.${PYVER}\tools\Scripts"'

  ; Uninstall files
    Delete "$INSTDIR\logo.ico"
    Delete "$INSTDIR\LICENSE"
    Delete "$INSTDIR\_system_path.py"
  ; Uninstall directories
    RMDir /r "$INSTDIR\python.${PYVER}${ARCH_VERSION}"
    RMDir /r "$INSTDIR\docs"
    RMDir /r "$INSTDIR\example_scenes"

  RMDir $INSTDIR
  DeleteRegKey SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
SectionEnd


; Functions

Function .onMouseOverSection
    ; Find which section the mouse is over, and set the corresponding description.
    FindWindow $R0 "#32770" "" $HWNDPARENT
    GetDlgItem $R0 $R0 1043 ; description item (must be added to the UI)

    StrCmp $0 ${sec_app} "" +2
      SendMessage $R0 ${WM_SETTEXT} 0 "STR:${PRODUCT_NAME}"

FunctionEnd

Function .onInit
  ; Multiuser.nsh breaks /D command line parameter. Parse /INSTDIR instead.
  ; Cribbing from https://nsis-dev.github.io/NSIS-Forums/html/t-299280.html
  ${GetParameters} $0
  ClearErrors
  ${GetOptions} '$0' "/INSTDIR=" $1
  IfErrors +2  ; Error means flag not found
    StrCpy $cmdLineInstallDir $1
  ClearErrors

  !insertmacro MULTIUSER_INIT

  ; If cmd line included /INSTDIR, override the install dir set by MultiUser
  StrCmp $cmdLineInstallDir "" +2
    StrCpy $INSTDIR $cmdLineInstallDir
FunctionEnd

Function un.onInit
  !insertmacro MULTIUSER_UNINIT
FunctionEnd

