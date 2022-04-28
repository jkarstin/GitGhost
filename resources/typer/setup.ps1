python -m venv env
./env/Scripts/activate
python -m pip install --upgrade pip

New-Item "./requirements.txt" -ItemType "file" -Value @"
typer[all]
"@
New-Item "./requirements-dev.txt" -ItemType "file" -Value @"
pytest
typer[all]
"@
python -m pip install -r "requirements-dev.txt"

$m_dd_yyyy = Get-Date -Format "MM.dd.yyyy"
New-Item "./main.py" -ItemType "file" -Value @"
#################################
# main.py
#-------------------------------
# J Karstin Neill    $m_dd_yyyy
#################################


### IMPORTS ###

import typer


### CONSTANTS ###


### MAIN FUNCTION DEFINITION ###

app = typer.Typer(add_completion=False)

@app.command()
def main():
    typer.echo('Hello world!')


### CORE FUNCTIONS ###




### UTILITY FUNCTIONS ###




### MAIN FUNCTION EXECUTION ###

if __name__ == '__main__':
    app()

"@
New-Item "./test_main.py" -ItemType "file" -Value @"
import main


def test_main():
    pass

"@

New-Item ./.gitignore -ItemType 'file' -Value @"
env/
*.ps1
__pycache__/
.pytest_cache/
"@
