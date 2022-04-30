$EGG     = Split-Path $MyInvocation.MyCommand.Path -Parent
$KITCHEN = Resolve-Path "$EGG\.."
$YOLK    = "$EGG\.yolk"

if (Test-Path "$KITCHEN\.gitignore") {
    $EggGitIgnoreContent = Get-Content "$YOLK\.gitignore"

    $EggGitIgnore = ""
    foreach ($Line in $EggGitIgnoreContent) {
        $EggGitIgnore += "`n$Line"
    }

    Add-Content "$KITCHEN\.gitignore" "`n`n#$(Split-Path $Egg -Leaf)$EggGitIgnore"
    Remove-Item "$YOLK\.gitignore"
}

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

