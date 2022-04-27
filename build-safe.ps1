Set-Location .\DevScripts\
git remote rm origin
Move-Item .\root\* ..\
Remove-Item .\root\
Set-Location ..\

.\setup.ps1
