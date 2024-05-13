function Get-DieRoll
{
    [CmdletBinding()]
    param (
        [Parameter()]
        [ValidateSet(4, 6, 8, 10, 12, 20)]
        [int]
        $die = 6,

        # How Many dice to roll
        [Parameter()]
        [int]
        $Count
    )

    If ($Count -gt 0)
    {
    (1..$Count) | ForEach-Object {
        (1..$die) | Get-Random
        }
    }
}
