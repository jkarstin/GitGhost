$EGG     = Split-Path $MyInvocation.MyCommand.Path -Parent
$KITCHEN = Resolve-Path "$EGG\.."
$YOLK    = "$EGG\.yolk"

if (Test-Path "$KITCHEN\.gitignore") {
    Add-Content "$KITCHEN\.gitignore" "`n`n#$(Split-Path $Egg -Leaf)`n$(Get-Content "$YOLK\.gitignore")"
    Remove-Item "$YOLK\.gitignore"
}

Move-Item "$YOLK\*" $KITCHEN

Set-Location $KITCHEN

python -m venv env
.\Scripts\activate
python -m pip install --upgrade pip
python -m pip install -r "requirements-dev.txt"

$m_dd_yyyy = Get-Date -Format "MM.dd.yyyy"
((Get-Content ".\main.py" -Raw) -Replace "<M_DD_YYY>",$m_dd_yyyy) | Set-Content ".\main.py"