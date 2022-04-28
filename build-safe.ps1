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
        
        Set-Location $buildrepo

        Copy-Item "$ggmodule\*" $buildrepo
        Copy-Item "$ggcommon\*" $buildrepo

        $reponame = Split-Path $buildrepo -Leaf
        $datestr = Get-Date -Format "MM.dd.yyyy @ HH:mm (UTCK)"
        (((Get-Content "$buildrepo\README.md" -Raw) -Replace "<REPO_NAME>",$reponame) -Replace "<DATE_STRING>",$datestr) | Set-Content "$buildrepo\README.md"
        
        .\setup.ps1
        Remove-Item ".\setup.ps1"

        git init .
        git add .
        git commit -m "Initial commit"
    }
}
