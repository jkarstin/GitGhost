function Main {
    param (
        $GGMod
    )

    $GGRepo      = Split-Path $MyInvocation.MyCommand.Path -Parent
    $GGResources = $GGRepo\resources
    $GGCommon    = $GGResources\common
    $GGModules   = $GGRepo\modules

    $GGModule = $GGModules\$GGMod

    if (-Not (Test-Path $GGModule)) {
        Write-Error "Could not locate '$GGMod' module!"
    }
    else {
        $BuildRepo = $GGRepo\..
        $RepoName  = Split-Path $BuildRepo -Leaf

        Set-Location $GGRepo
        
        git remote rm origin
        
        Set-Location $BuildRepo

        Copy-Item -Recurse "$GGModule\*" $BuildRepo

        if (Test-Path "$BuildRepo\.gitignore") {
            $GGCommonGI = Get-Content "$GGCommon\.gitignore"
            Add-Content "$BuildRepo\.gitignore" "`n`n#GitGhost`n$GGCommonGI"
        }
        else {
            Copy-Item "$GGCommon\.gitignore" $BuildRepo
        }
        
        Copy-Item "$GGCommon\README.md" $BuildRepo
        Copy-Item -Recurse "$GGCommon\GG" $BuildRepo
        
        Remove-Item -Recurse -Force $GGRepo

        $DateString = Get-Date -Format "MM.dd.yyyy @ HH:mm (UTCK)"
        (((Get-Content "$BuildRepo\README.md" -Raw) -Replace "<REPO_NAME>",$RepoName) -Replace "<DATE_STRING>",$DateString) | Set-Content "$BuildRepo\README.md"
        
        .\setup.ps1
        Remove-Item ".\setup.ps1"

        git init .
        git add .
        git commit -m "Initial commit"
    }
}

if ($args.count -ne 1) {
    Write-Error "Expected <module_name> argument!"
}
else {
    Main $args[0]
}