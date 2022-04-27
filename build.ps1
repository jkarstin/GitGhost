Set-Location .\DevScripts\
git remote rm origin
Move-Item .\root\* ..\
Set-Location ..\
Remove-Item -Recurse -Force .\DevScripts\

.\Scripts\setup.ps1
