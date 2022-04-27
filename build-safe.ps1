Set-Location .\DevScripts\
git remote rm origin
Move-Item .\root\* ..\
Set-Location ..\

.\Scripts\setup.ps1
