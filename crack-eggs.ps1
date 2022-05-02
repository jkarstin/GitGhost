#####################################
# crack-eggs.ps1     [v0.1.0-alpha] #
#===================================#
#                                   #
#-----------------------------------#
# J Karstin Neill        05.02.2022 #
#####################################


### CONSTANTS & FLAGS ###

$GG_KITCHEN = Split-Path $MyInvocation.MyCommand.Path -Parent

$CRACK_SCRIPT      = ".crack.ps1"
$CLASSIC_EGG_SIGNS = @(".eggshell", ".yolk", $CRACK_SCRIPT)

$EXIT_SUCCESS          =   0
$ERROR_INCORRECT_USAGE =   1
$ERROR_DETACH_GIT      =   2
$ERROR_EGG_NOT_FOUND   = 404
$ERROR_DECOY_EGG       =  69

$Global:SAFE_MODE = $False


### MAIN FUNCTION DEFINITION ###

function Execute-Main {
    param (
        [string[]] $Argv,
        [int]      $Argc
    )

    $GhostCarton = ".ghost.carton"
    $EggCarton   = "egg.carton"

    $GhostEggs = @(".GG")
    $Eggs = Parse-Argv $Argv $Argc

    $NewKitchen = Prep-Kitchen
    
    Get-Cracking $GhostEggs $GhostCarton $NewKitchen
    Get-Cracking $Eggs $EggCarton $NewKitchen

    Git-Up-And-Ghost $NewKitchen
}


### SOUS-CHEF FUNCTIONS ###

function Prep-Kitchen {
    Log "Preparing kitchen for impending egg cracking..."

    $NewKitchen = Resolve-Path "$GG_KITCHEN\.."

    if ($SAFE_MODE) {
        Copy-Item -Recurse "$GG_KITCHEN\.resources\.kitchen" $NewKitchen
        Copy-Item "$GG_KITCHEN\.resources\.gitignore" $NewKitchen
    }
    else {
        Detach-Git $GG_KITCHEN
        Move-Item "$GG_KITCHEN\.resources\.kitchen" $NewKitchen
        Move-Item "$GG_KITCHEN\.resources\.gitignore" $NewKitchen
    }

    $Floorplan = Get-Item "$NewKitchen\.kitchen\.floorplan"
    (Get-Content $Floorplan -Raw) -Replace "<KITCHEN_NAME>", "$(Split-Path $NewKitchen -Leaf)" | `
    Set-Content $Floorplan

    return $NewKitchen
}


function Get-Cracking {
    param (
        [string[]] $Eggs,
        [string]   $Carton,
        [string]   $Kitchen
    )

    Log "Opening carton '$Carton' in kitchen '$(Split-Path $Kitchen -Leaf)'..."

    foreach ($Egg in $Eggs) {
        Crack-Egg $Egg $Carton $Kitchen
    }

    Set-Location $Kitchen

    foreach ($Egg in $Eggs) {
        Cleanup-Eggshell $Egg $Kitchen
    }
}


function Crack-Egg {
    param (
        [string] $Egg,
        [string] $Carton,
        [string] $Kitchen
    )

    Log "Looking in carton '$Carton' for egg '$Egg'..."

    if (-Not (Test-Path "$GG_KITCHEN\$Carton\$Egg.egg")) {
        Error-Exit "Could not locate egg '$Egg' in carton '$Carton' [$GG_KITCHEN\$Carton\$Egg.egg]!" $ERROR_EGG_NOT_FOUND
    }

    Log "Verifying egg '$Egg' isn't a decoy..."

    foreach ($EggSign in $CLASSIC_EGG_SIGNS) {
        if (-Not (Test-Path "$GG_KITCHEN\$Carton\$Egg.egg\$EggSign")) {
            Error-Exit "Egg '$Egg' from carton '$Carton' is missing required egg sign '$EggSign'! [$GG_KITCHEN\$Carton\$Egg.egg]!" $ERROR_DECOY_EGG
        }
    }

    Log "Looks like a fine egg! Cracking into kitchen '$(Split-Path $Kitchen -Leaf)'..."

    if ($SAFE_MODE) {
        Copy-Item -Recurse "$GG_KITCHEN\$Carton\$Egg.egg" $Kitchen
    }
    else {
        Move-Item "$GG_KITCHEN\$Carton\$Egg.egg" $Kitchen
    }
    
    Set-Location "$Kitchen\$Egg.egg"

    Summon-Ghost $Egg $Kitchen

    Invoke-Expression ".\$CRACK_SCRIPT"
}


function Summon-Ghost {
    param (
        [string] $Egg,
        [string] $Kitchen
    )

    $EggGhost = New-Item "$Kitchen\.kitchen\$Egg.ghost" -ItemType "file"
    Add-Content $EggGhost "#$Egg.ghost"
}


function Cleanup-Eggshell {
    param (
        [string] $Egg,
        [string] $Kitchen
    )

    Log "Cleaning up eggshell from egg '$Egg' cracked in kitchen '$(Split-Path $Kitchen -Leaf)'..."

    Remove-Item -Recurse "$Kitchen\$Egg.egg"

    Log "*washes hands* Alright, what's next?..."
}


### CHEF FUNCTIONS ###

function Git-Up-And-Ghost {
    param (
        [string] $Kitchen
    )

    Log "Time for the finishing touch!"

    Ghost-Kitchen $Kitchen
    Init-Git $Kitchen
}


function Ghost-Kitchen {
    param (
        [string] $Kitchen
    )

    Set-Location $Kitchen

    if (-Not $SAFE_MODE) {
        Remove-Item -Recurse -Force $GG_KITCHEN
    }

    Log "See-ya! *vanishes in a poof*"
}


### UTILITY FUNCTIONS ###

function Parse-Argv {
    param (
        [string[]] $Argv,
        [int]      $Argc
    )

    if ($Argc -lt 1) {
        Error-Exit "Expected at least one <egg_name> argument!" $ERROR_INCORRECT_USAGE
    }

    $ArgvParsed = @()
    foreach ($Arg in $Argv) {
        if ($Arg.ToLower() -eq "--safe") {
            $Global:SAFE_MODE = $True
        }
        else {
            $ArgvParsed += $Arg
        }
    }

    return $ArgvParsed
}


function Detach-Git {
    param (
        [string] $RepoPath
    )

    $RepoName = Split-Path $RepoPath -Leaf
    Log "Detaching '$RepoName' from origin..."

    if (-Not (Test-Path "$RepoPath\.git")) {
        Error-Exit "Failed to detach git! '$RepoName' appears not to be a valid git repository!" $ERROR_DETACH_GIT
    }

    $StartPwd = $pwd
    Set-Location $RepoPath
    git remote rm origin
    Set-Location $StartPwd
}


function Init-Git {
    param (
        [string] $RepoPath
    )

    Log "Setting up new git repository '$(Split-Path $RepoPath -Leaf)'..."

    Set-Location $RepoPath

    git init .
    git checkout -B stable
    git add .
    git commit -m "Initial commit"
    
    git branch --track alpha stable
    git branch --track dev alpha
}


function Log {
    param (
        [string] $Message
    )

    Write-Host $Message
}


function Error-Exit {
    param (
        [string] $Message,
        [int] $ErrorCode
    )

    Write-Error $Message
    Exit $ErrorCode
}


### MAIN FUNCTION EXECUTION ###

Execute-Main $args $args.count