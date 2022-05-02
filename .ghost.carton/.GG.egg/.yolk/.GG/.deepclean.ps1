$GG = Split-Path $MyInvocation.MyCommand.Path -Parent

if ((Split-Path $GG -Leaf) -ne ".GG") {
    Write-Error "Unsafe to execute this script unless it is within the .GG directory!"
    Exit 86
}

$Kitchen = Resolve-Path "$GG\.."
Remove-Item -Recurse -Force "$Kitchen\*"
