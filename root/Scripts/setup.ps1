python -m venv env
./env/Scripts/activate
python -m pip install --upgrade pip

New-Item ./requirements.txt -ItemType 'file' -Value @"
pygame
typing
"@
New-Item ./requirements-dev.txt -ItemType 'file' -Value @"
pytest
pygame
typing
"@
python -m pip install -r 'requirements-dev.txt'

$m_dd_yyyy = Get-Date -Format 'MM.dd.yyyy'
New-Item ./main.py -ItemType 'file' -Value @"
#################################
# main.py
#-------------------------------
# J Karstin Neill    $m_dd_yyyy
#################################


### IMPORTS ###

import pygame
import sys


### CONSTANTS ###

EXIT_SUCCESS = 0


### MAIN FUNCTION DEFINITION ###

def main(argv: list[str], argc: int) -> int:
    print('Hello world!')
    
    if argc > 1:
        print(argv)

    return EXIT_SUCCESS


### CORE FUNCTIONS ###




### UTILITY FUNCTIONS ###




### MAIN FUNCTION EXECUTION ###

if __name__ == '__main__':
    pygame.init()
    argv: list[str] = sys.argv
    argc: int = len(argv)
    sys.exit(main(argv, argc))

"@

$repo = Split-Path -Path $pwd -Leaf
New-Item ./.gitignore -ItemType 'file' -Value @"
env/
*.ps1
"@
New-Item ./README.md -ItemType 'file' -Value @"
# $repo
"@

Remove-Item ./Scripts/setup.ps1

git init .
git commit -a -m "Initial commit"
