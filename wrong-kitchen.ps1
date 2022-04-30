if ($args.count -ne 1) {
    Write-Error "Requires single argument <path_to_target_repo>!"
}
else {
    $buildrepo = $args[0]
    if (-Not (Test-Path $buildrepo)) {
        Write-Error "Given <path_to_target_repo> ['$buildrepo'] could not be located!"
    }
    else {
        $ggold = Split-Path $MyInvocation.MyCommand.Path -Parent

        Set-Location $ggold
        git remote rm origin

        Set-Location $buildrepo
        git clone https://github.com/jkarstin/GitGhost
        Remove-Item -Recurse -Force $ggold
    }
}