python -m venv env
./Scripts/activate
python -m pip install --upgrade pip
python -m pip install -r "requirements-dev.txt"

$m_dd_yyyy = Get-Date -Format "MM.dd.yyyy"
((Get-Content ".\main.py" -Raw) -Replace "<M_DD_YYY>",$m_dd_yyyy) | Set-Content ".\main.py"