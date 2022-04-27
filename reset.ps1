if ($args.count -ne 1) {
    Write-Error "Requires single argument <path_to_target_repo>!"
}
elseif (-Not (Test-Path -Path $args[0])) {
    $path = $args[0]
    Write-Error "Given <path_to_target_repo> ['$path'] could not be located!"
}
else {
    $old = $pwd
    git remote rm origin
    Set-Location $args[0]
    git clone https://github.com/jkarstin/DevScripts
    Remove-Item -Recurse -Force $old
}