Set-PSReadLineOption -BellStyle None -EditMode Emacs
$OutputEncoding = [console]::InputEncoding = [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding
Set-PSReadLineKeyHandler -Chord ctrl+w -Function BackwardDeleteWord
Set-PSReadLineKeyHandler -Chord ctrl+j -Function AcceptLine
Set-PSReadLineKeyHandler -Chord ctrl+v -Function Paste
Set-PSReadLineKeyHandler -Chord "alt+;" -ScriptBlock {ConvertTo-Comment}
function ConvertTo-Comment{
  # Mimic pound-insert in zsh or insert-comment in bash
  [Microsoft.PowerShell.PSConsoleReadLine]::BeginningOfLine();
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("# ");
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

<#
# Ooops, cannot invoke editor like vim while using hotkey.
$env:EDITOR="code"
$EDITOR=$env:EDITOR
function Edit-CommandLine {
  # https://github.com/zsh-users/zsh/blob/3d7215cc8277b39cd1e24ce5a04376d45bfbabf0/Functions/Zle/edit-command-line
  $line = 0
  $cursor = 0
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
  $temp = New-TemporaryFile
  Out-File $temp -InputObject $line
  $ed = $env:EDITOR
  switch($ed){
    "vim" {Invoke-Expression "$ed -c `"normal! ${cursor}go`" -- $temp"; Break}
    "emacs" {Invoke-Expression ("$ed +" + ($line.Length) + " $temp"); Break}
    default {Invoke-Expression "$ed $temp"}
  }
  [Microsoft.PowerShell.PSConsoleReadLine]::NextLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert((cat $temp))
}
Set-PSReadLineKeyHandler -Chord "ctrl+x,ctrl+e" -ScriptBlock {Edit-CommandLine}
#>

function Open-ProcessFolder{
  param(
    [Parameter(Mandatory = $true, ParameterSetName = "Name")]
    [String] $path
  )
  get-process | where-object -property name -match $name | select-object -ExpandProperty path -first 1 | split-path | invoke-item
}
function hex {
  param([Parameter(ValueFromPipeline)]$Number)
  process {
    [convert]::ToString($Number, 16);
  }
}
function bin {
  param([Parameter(ValueFromPipeline)]$Number)
  process {
    [convert]::ToString($Number, 2);
  }
}

Import-Module Get-ChildItemColor
Import-Module z
Import-Module posh-git
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Remove-Variable HOME -Force
New-Variable HOME -Value $env:HOME -Option ReadOnly # Make $HOME same with your environment
$ExecutionContext.SessionState.Drive.Current.Provider.Home = $HOME # Also make ~ to be the new Home
Set-Alias .. cd..
Set-Alias * Select
Set-Alias lw Get-ChildItemColorFormatWide
