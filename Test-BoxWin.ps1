function Test-BoxWin
{
    [CmdletBinding()]
    param (
        # The box object
        [Parameter(Mandatory)]
        [PSCustomObject]
        $Box
    )

    process
    {
        $Box.1 -and $Box.2 -and $Box.3 -and $Box.4 -and $Box.5 -and $Box.6 -and $Box.7 -and $Box.8 -and $Box.9
    }
}
