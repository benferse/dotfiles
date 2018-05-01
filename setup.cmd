:: Initialization script for Windows. There is less of a convention
:: for where dotfiles and such are placed on Windows, so this is
:: mostly linking individual files and directories to the right place
:: in the user profile
::
:: Needs to run as an administrator, or you need the SeCreateSymbolicLink
:: privilege, or you need to be on Windows 10 with developer mode enabled.

@echo off

set ConfigRoot=%~dp0config

:: vscode
echo Linking settings for vscode...

del /f /q "%appdata%\Code\User\settings.json" 2> nul:
mklink "%appdata%\Code\User\settings.json" "%ConfigRoot%\vscode\settings.json"

del /f /q "%appdata%\Code\User\keybindings.json" 2> nul:
mklink "%appdata%\Code\User\keybindings.json" "%ConfigRoot%\vscode\keybindings.json"

:: clink
echo Linking settings for clink...

del /f /q "%localappdata%\clink\clink-benferse.lua" 2> nul:
mklink "%localappdata%\clink\clink-benferse.lua" "%ConfigRoot%\clink\clink-benferse.lua"

:: hyper
echo Linking settings for hyper...

del /f /q "%userprofile%\.hyper.js" 2> nul:
mklink "%userprofile%\.hyper.js" "%ConfigRoot%\hyper\.hyper.js"

:: nvim
echo Linking settings for nvim...

rd /q "%localappdata%\nvim" 2> nul:
mklink /d "%localappdata%\nvim" "%ConfigRoot%\nvim"

echo Done.
