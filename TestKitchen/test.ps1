function Print-Array {
    param (
        $arr
    )

    $n = $arr.count
    Write-Output "n: $n"
    Write-Output $arr
}

function Error-Test {
    Write-Output "Before Error Test"

    Write-Error "Error Test"

    Write-Output "After Error Test"

    return

    Write-Output "After Return"
}

function Def-Order-Test2 {
    Write-Output "Def-Order-Test2"

    Def-Order-Test1
}

function Def-Order-Test1 {
    Write-Output "Def-Order-Test1"
}

Def-Order-Test2