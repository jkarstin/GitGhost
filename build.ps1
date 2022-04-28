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

        Copy-Item -Recurse "$ggmodule\*" $buildrepo

        if (Test-Path "$buildrepo\.gitignore") {
            $ggcommongi = Get-Content "$ggcommon\.gitignore"
            Add-Content "$buildrepo\.gitignore" "`n`n#GitGhost`n$ggcommongi"
        }
        else {
            Copy-Item "$ggcommon\.gitignore" $buildrepo
        }
        
        Copy-Item "$ggcommon\README.md" $buildrepo
        Copy-Item -Recurse "$ggcommon\GG" $buildrepo
        
        Remove-Item -Recurse -Force $ggrepo

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
