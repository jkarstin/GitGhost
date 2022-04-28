$ggrepo      = Split-Path $MyInvocation.MyCommand.Path -Parent
$ggresources = "$ggrepo\resources"
$ggcommon    = "$ggresources\common"
$buildrepo   = "$ggrepo\.."

if ($args.count -ne 1) {
    Write-Error "Expected <project_module> argument!"
}
else {
    $ptype = $args[0]
    $ggmodule = "$ggresources\$ptype"

    if (-Not (Test-Path $ggmodule)) {
        Write-Error "Could not locate '$ptype' project module!"
    }
    else {
        Set-Location $ggrepo

        git remote rm origin
        Move-Item "$ggmodule\*" $buildrepo

        Set-Location $buildrepo

        $reponame = Split-Path $buildrepo -Leaf
        $datestr = Get-Date -Format "MM.dd.yyyy @ HH:mm (UTCK)"
        Copy-Item "$ggcommon\README.md" $buildrepo
        (((Get-Content ".\README.md" -Raw) -Replace "<REPO_NAME>",$reponame) -Replace "<DATE_STRING>",$datestr) | Set-Content ".\README.md"

        .\setup.ps1

        git init .
        git add .
        git commit -m "Initial commit"
    }
}
