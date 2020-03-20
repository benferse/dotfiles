:: Initialization script for Windows. There is less of a convention
:: for where dotfiles and such are placed on Windows, so this is
:: mostly linking individual files and directories to the right place
:: in the user profile
::
:: Wherever possible, standard XDG locations are used so Windows vs. *nix
:: setups can "just work", as much as humanly possible
::
:: Needs to run as an administrator, or you need the SeCreateSymbolicLink
:: privilege, or you need to be on Windows 10 with developer mode enabled
:: (which confers the latter)

@echo off

set ConfigRoot=%~dp0.config

set XDG_CONFIG_HOME=%HOMEDRIVE%%HOMEPATH%\.config
echo Setting XDG_CONFIG_HOME to %XDG_CONFIG_HOME%
setx XDG_CONFIG_HOME %HOMEDRIVE%%HOMEPATH%\.config

set XDG_DATA_HOME=%HOMEDRIVE%%HOMEPATH%\.local\share
echo Setting XDG_DATA_HOME to %XDG_DATA_HOME%
setx XDG_DATA_HOME %HOMEDRIVE%%HOMEPATH%\.local\share

:: vscode
echo Linking settings for vscode...

del /f /q "%appdata%\Code\User\settings.json" 2> nul:
mklink "%appdata%\Code\User\settings.json" "%ConfigRoot%\vscode\settings.json"

del /f /q "%appdata%\Code\User\keybindings.json" 2> nul:
mklink "%appdata%\Code\User\keybindings.json" "%ConfigRoot%\vscode\keybindings.json"

:: vscode - insiders edition (if installed)
if exist "%appdata%\Code - Insiders" 2> nul: (

    echo Linking settings for vscode insiders edition...

    del /f /q "%appdata%\Code - Insiders\User\settings.json" 2> nul:
    mklink "%appdata%\Code - Insiders\User\settings.json" "%ConfigRoot%\vscode\settings.json"

    del /f /q "%appdata%\Code - Insiders\User\keybindings.json" 2> nul:
    mklink "%appdata%\Code - Insiders\User\keybindings.json" "%ConfigRoot%\vscode\keybindings.json"

)

:: clink
echo Linking settings for clink...

del /f /q "%localappdata%\clink\clink-benferse.lua" 2> nul:
mklink "%localappdata%\clink\clink-benferse.lua" "%ConfigRoot%\clink\clink-benferse.lua"

:: Windows Terminal
echo Linking settings for Windows Terminal...

del /f /q "%localappdata%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\profiles.json" 2> nul:
copy "%ConfigRoot%\cascadia\profiles.json" "%localappdata%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\profiles.json" 2> nul:

:: nvim
echo Linking settings for nvim...

del /f /q "%XDG_CONFIG_HOME%\nvim" 2> nul:
mklink "%XDG_CONFIG_HOME%\nvim" "%ConfigRoot%\nvim"

echo Done.

exit /b 0
