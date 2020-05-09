using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Invoke-Expression (&starship init powershell)

Import-Module PSReadLine

Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

<#
.SYNOPSIS
Sets the shell's location to the root of the current git repository
.DESCRIPTION
If invoked from any subdirectory of a git repository, this will determine
the root of the repository (i.e. the location of the .git folder) and cd
there.
#>
function Invoke-GoToGitRoot {
    Set-Location "$(git rev-parse --show-toplevel)"
}

Set-Alias -Name root -Value Invoke-GoToGitRoot
