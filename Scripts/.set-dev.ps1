$GG_KITCHEN = Split-Path $MyInvocation.MyCommand.Path -Parent
$START_PWD = $Pwd

Set-Location $GG_KITCHEN
git checkout dev
Set-Location $START_PWD
