if ($args.count -ne 1) {
    Write-Error "Requires single argument <path_to_target_repo>!"
}
else {
    $path = $args[0]
    if (-Not (Test-Path $path)) {
        Write-Error "Given <path_to_target_repo> ['$path'] could not be located!"
    }
    else {
        $old = Split-Path $MyInvocation.MyCommand.Path -Parent
        Set-Location $old
        git remote rm origin
        Set-Location $path
        git clone https://github.com/jkarstin/DevScripts
        Remove-Item -Recurse -Force $old
    }
}