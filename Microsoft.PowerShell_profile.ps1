Set-PSReadLineOption -EditMode Emacs

function Open-ProcessFolder{
  param(
    [Parameter(Mandatory = $true, ParameterSetName = "Name")]
    [String] $path
  )
  get-process | where -property name -match $name | select path -first 1 | split-path | ii
}

Import-Module posh-git
Remove-Variable HOME -Force
Set-Variable HOME $env:HOME