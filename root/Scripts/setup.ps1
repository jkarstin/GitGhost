python -m venv env
./env/Scripts/activate
python -m pip install --upgrade pip

New-Item -Path . -Name 'requirements.txt' -ItemType 'file' -Value @"
pygame
typing
"@
New-Item -Path . -Name 'requirements-dev.txt' -ItemType 'file' -Value @"
pytest
pygame
typing
"@
python -m pip install -r 'requirements-dev.txt'

$m_dd_yyyy = Get-Date -Format 'MM.dd.yyyy'
New-Item -Path . -Name 'main.py' -ItemType 'file' -Value @"
#################################
# main.py
#-------------------------------
# J Karstin Neill    $m_dd_yyyy
#################################


### IMPORTS ###

import pygame
import sys
import typing


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
New-Item -Path . -Name '.gitignore' -ItemType 'file' -Value @"
env/
*.ps1
"@
New-Item -Path . -Name 'README.md' -ItemType 'file' -Value @"
# $repo
"@

git init .
git add .
git commit -m "Initial commit"
