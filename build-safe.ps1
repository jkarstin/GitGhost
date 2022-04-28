if ($args.count -ne 1) {
    Write-Error "Expected <project_type> argument!"
}
else {
    $ptype = $args[0]
    if (-Not (Test-Path ".\GitGhost\resources\$ptype")) {
        Write-Error "Could not locate '$ptype' project type!"
    }
    else {
        Set-Location ".\GitGhost\"
        git remote rm origin
        Move-Item ".\resources\$ptype\*" "..\"

        Set-Location "..\"
        $repo = Split-Path $pwd -Leaf
        $datestr = Get-Date -Format "MM.dd.yyyy @ HH:mm (UTCK)"

        Copy-Item ".\GitGhost\resources\common\README.md" ".\"
        (((Get-Content ".\README.md" -Raw) -Replace "<REPO_NAME>",$repo) -Replace "<DATE_STRING>",$datestr) | Set-Content ".\README.md"

        .\setup.ps1

        git init .
        git add .
        git commit -m "Initial commit"
    }
}
