:: Initialization script for Windows. There is less of a convention
:: for where dotfiles and such are placed on Windows, so this is
:: mostly linking individual files and directories to the right place
:: in the user profile.
::
:: Wherever possible, standard XDG locations are used so Windows vs. *nix
:: setups can "just work", as much as humanly possible.
::
:: Needs to run as an administrator, or you need the SeCreateSymbolicLink
:: privilege, or you need to be on Windows 10 with developer mode enabled
:: (which confers the latter).

@echo off

set ConfigRoot=%~dp0config

set XDG_CONFIG_HOME=%USERPROFILE%\.config
echo Setting XDG_CONFIG_HOME to %XDG_CONFIG_HOME%
setx XDG_CONFIG_HOME %USERPROFILE%\.config

set XDG_DATA_HOME=%USERPROFILE%\.local\share
echo Setting XDG_DATA_HOME to %XDG_DATA_HOME%
setx XDG_DATA_HOME %USERPROFILE%\.local\share

:: vscode
if exist "%appdata%\Code" 2> nul: (
    echo Linking settings for vscode...

    del /f /q "%appdata%\Code\User\settings.json" 2> nul:
    mklink "%appdata%\Code\User\settings.json" "%ConfigRoot%\vscode\settings.json"

    del /f /q "%appdata%\Code\User\keybindings.json" 2> nul:
    mklink "%appdata%\Code\User\keybindings.json" "%ConfigRoot%\vscode\keybindings.json"
)

:: Windows Terminal
if exist "%localappdata%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe" 2> nul: (
    echo Linking settings for Windows Terminal from MS store...

    del /f /q "%localappdata%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\profiles.json" 2> nul:
    del /f /q "%localappdata%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" 2> nul:
    mklink "%localappdata%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" "%ConfigRoot%\cascadia\settings.json" 2> nul:
)

:: nvim
echo Linking settings for nvim...

rmdir /q "%XDG_CONFIG_HOME%\nvim" 2> nul:
mklink /d "%XDG_CONFIG_HOME%\nvim" "%ConfigRoot%\nvim"

:: Powershell Core profile
echo Linking settings for pscore...

del /f /q "%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" 2> nul:
mklink "%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" "%ConfigRoot%\powershell\profile.ps1"

:: starship
echo Linking settings for starship...

del /f /q "%XDG_CONFIG_HOME%\starship.toml" 2> nul:
mklink "%XDG_CONFIG_HOME%\starship.toml" "%ConfigRoot%\starship\starship.toml"

:: git
echo Linking settings for git...

del /f /q "%USERPROFILE%\.gitconfig" 2> nul:
mklink "%USERPROFILE%\.gitconfig" "%ConfigRoot%\git\gitconfig"

del /f /q "%XDG_CONFIG_HOME%\git\config" 2> nul:
mklink "%XDG_CONFIG_HOME%\git\config" "%ConfigRoot%\git\gitconfig.windows"

echo Done.

exit /b 0
