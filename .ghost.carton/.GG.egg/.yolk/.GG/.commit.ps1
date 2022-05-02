if ($args.count -ne 1) {
    Write-Error "Expected <commit_message>!"
}
else {
    $message = $args[0]
    
    git add .
    git commit -m $message
}