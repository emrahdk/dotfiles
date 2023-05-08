oh-my-posh init pwsh --config C:\Users\emrah\.mytheme.omp.json | Invoke-Expression

## Get fancy directory listing
Import-Module -Name Terminal-Icons

## Add git autocomplete
Import-Module posh-git

## Add NPM autocomplete
Import-Module npm-completion

## Add history autocomplete
if ($host.Name -eq 'ConsoleHost')
{
  Import-Module PSReadLine
  Set-PSReadLineOption -PredictionSource HistoryAndPlugin
  Set-PSReadLineOption -PredictionViewStyle InlineView #ListView
  Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
  Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
  Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
  Set-PSReadLineOption -ShowToolTips
  Set-PSReadLineOption -HistorySearchCursorMovesToEnd
}

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
  param($commandName, $wordToComplete, $cursorPosition)
  dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
    [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
  }
}

# Aliases & functions
## Git
function gitwrecked { git reset --hard HEAD }
function gl { git log --oneline --decorate --color --graph $args }
function glo { git log --oneline --decorate --color $args }
function gs { git status }

## Bash-like commands
function dl { Get-ChildItem $args | Format-Wide -column 3 }
