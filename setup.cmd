:: Initialization script for Windows. There is less of a convention
:: for where dotfiles and such are placed on Windows, so this is
:: mostly linking individual files and directories to the right place
:: in the user profile
::
:: Needs to run as an administrator, or you need the SeCreateSymbolicLink
:: privilege, or you need to be on Windows 10 with developer mode enabled
:: (which confers the latter)

@echo off

set ConfigRoot=%~dp0config

:: vscode
echo Linking settings for vscode...

del /f /q "%appdata%\Code\User\settings.json" 2> nul:
mklink "%appdata%\Code\User\settings.json" "%ConfigRoot%\vscode\settings.json"

del /f /q "%appdata%\Code\User\keybindings.json" 2> nul:
mklink "%appdata%\Code\User\keybindings.json" "%ConfigRoot%\vscode\keybindings.json"

:: vscode - insiders edition (if installed)
if exist "%appdata%\Code - Insiders" 2> nul: (

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

echo Done.
