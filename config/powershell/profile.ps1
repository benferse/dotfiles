using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Invoke-Expression (&starship init powershell)

Import-Module PSReadLine

Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
