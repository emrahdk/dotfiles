oh-my-posh init pwsh --config C:\Users\ekaya\.mytheme.omp.json | Invoke-Expression

# Add git autocomplete
Import-Module posh-git

## Get fancy directory listing
Import-Module -Name Terminal-Icons

## Add NPM autocomplete
Import-Module npm-completion

# Add history autocomplete
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

# Aliases & functions
## Git
function gitwrecked { git reset --hard HEAD }
function gs { git status }
function gswc { git switch -c $args }
function gswm { git switch main }
function gsl { git stash list }
function gsp { git stash pop }
function gitprune { git for-each-ref --format '%(refname:short)' refs/heads --merged | ForEach-Object { If("develop","master","main" -notcontains $_) { git branch $_ -d } } }

function gl { git log --oneline --decorate --color --graph @args }
$glScriptBlock = {
    param($wordToComplete, $commandAst, $cursorPosition)
    Expand-GitCommand "git log --oneline --decorate --color --graph $wordToComplete"
}
Register-ArgumentCompleter -Native -CommandName gl -ScriptBlock $glScriptBlock

function glo { git log --oneline --decorate --color @args }
$gloScriptBlock = {
    param($wordToComplete, $commandAst, $cursorPosition)
    Expand-GitCommand "git log --oneline --decorate --color $wordToComplete"
}
Register-ArgumentCompleter -Native -CommandName glo -ScriptBlock $gloScriptBlock

function gsw { git switch @args }
$gswScriptBlock = {
    param($wordToComplete, $commandAst, $cursorPosition)
    Expand-GitCommand "git switch $wordToComplete"
}
Register-ArgumentCompleter -Native -CommandName gsw -ScriptBlock $gswScriptBlock

function gitup { git push -u origin @args }
$gitupScriptBlock = {
    param($wordToComplete, $commandAst, $cursorPosition)
    Expand-GitCommand "git push -u origin $wordToComplete"
}
Register-ArgumentCompleter -Native -CommandName gitup -ScriptBlock $gitupScriptBlock

## Others
function e. { explorer . }
function dl { Get-ChildItem $args | Format-Wide -column 3 }
