$GG = Split-Path $MyInvocation.MyCommand.Path -Parent

if (Split-Path $GG -Leaf -ne "GG") {
    Write-Error "Unsafe to execute this script unless it is within the GG directory!"
    Exit 86
}

$Kitchen = Resolve-Path "$GG\.."

if (Test-Path "$Kitchen\.git") {
    Set-Location $Kitchen
    git remote rm origin
}

Set-Location "$Kitchen\.."
Remove-Item -Recurse -Force "$Kitchen\*"
