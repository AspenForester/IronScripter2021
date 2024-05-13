function Test-BoxMove
{
    [CmdletBinding()]
    param (
        [Parameter()]
        [Int[]]
        $Move,

        # The Box object
        [Parameter(mandatory)]
        [object]
        $Box
    )
    # If *any* move is invalid, return $false

    $isMoveValid = $true

    $Move | Foreach-object {
        $isMoveValid = -not $box.$psitem
        if (-not $isMoveValid)
        {
            break
        }
    }

    $isMoveValid

}
