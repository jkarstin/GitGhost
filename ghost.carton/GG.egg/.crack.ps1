$KITCHEN = $args[0]

Move-Item ".\.yolk\*" $KITCHEN

Set-Location $KITCHEN

$DateString = Get-Date -Format "MM.dd.yyyy @ HH:mm (UTCK)"
(
    (
        (
            Get-Content "$KITCHEN\README.md" -Raw
        ) -Replace "<KITCHEN_NAME>", $(Split-Path $KITCHEN -Leaf)
    ) -Replace "<DATE_STRING>", $DateString
) | Set-Content "$KITCHEN\README.md"

