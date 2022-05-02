$EGG     = Split-Path $MyInvocation.MyCommand.Path -Parent
$KITCHEN = Resolve-Path "$EGG\.."
$YOLK    = "$EGG\.yolk"

if (Test-Path "$KITCHEN\.gitignore") {
    Add-Content "$KITCHEN\.gitignore" ""
}
else{
    $_ = New-Item "$KITCHEN\.gitignore" 
}
Add-Content "$KITCHEN\.gitignore" "#$(Split-Path $EGG -Leaf)"
Get-Content "$YOLK\.gitignore" | Add-Content "$KITCHEN\.gitignore"
Remove-Item "$YOLK\.gitignore"

Move-Item "$YOLK\*" $KITCHEN

Set-Location $KITCHEN

$DateString = Get-Date -Format "MM.dd.yyyy @ HH:mm (UTCK)"
(
    (
        (
            Get-Content "$KITCHEN\README.md" -Raw
        ) -Replace "<KITCHEN_NAME>", $(Split-Path $KITCHEN -Leaf)
    ) -Replace "<DATE_STRING>", $DateString
) | Set-Content "$KITCHEN\README.md"

