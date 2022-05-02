#######################################
# wrong-kitchen.ps1    [v0.1.0-alpha] #
#=====================================#
#                                     #
#-------------------------------------#
# J Karstin Neill          05.02.2022 #
#######################################


### CONSTANTS & FLAGS ###

$GG_KITCHEN = Split-Path $MyInvocation.MyCommand.Path -Parent

$EXIT_SUCCESS            =   0
$ERROR_INCORRECT_USAGE   =   1
$ERROR_KITCHEN_NOT_FOUND = 404


### MAIN FUNCTION DEFINITION ###

function Execute-Main {
    param (
        [string[]] $Argv,
        [int]      $Argc
    )

    if ($Argc -ne 1) {
        Error-Exit "Requires single argument <path_to_correct_repo>!" $ERROR_INCORRECT_USAGE
    }
    
    $CorrectKitchen = $Argv[0]
    
    if (-Not (Test-Path $CorrectKitchen)) {
        Error-Exit "Given <path_to_correct_repo> ['$CorrectKitchen'] could not be located!" $ERROR_KITCHEN_NOT_FOUND
    }

    Set-Location $GG_KITCHEN
    git remote rm origin
    Set-Location $CorrectKitchen
    git clone https://github.com/jkarstin/GitGhost
    Remove-Item -Recurse -Force $GG_KITCHEN

    Exit $EXIT_SUCCESS
}


### UTILITY FUNCTIONS ###

function Error-Exit {
    param (
        [string] $Message,
        [int] $ErrorCode
    )

    Write-Error $Message
    Exit $ErrorCode
}


### MAIN FUNCTION EXECUTION ###

Execute-Main $Args $Args.count
