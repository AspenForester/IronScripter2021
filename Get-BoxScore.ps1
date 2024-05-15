function Get-BoxScore
{
    [CmdletBinding()]
    param (
        # the box to score
        [Parameter(Mandatory)]
        [pscustomobject]
        $box
    )

    begin
    {

    }

    process
    {
        $Doors = Get-Member -InputObject $box -MemberType NoteProperty
        foreach ($door in $Doors)
        {
            if ($box.($door.name) -eq $false)
            {
                $score = $score + [int]$door.Name
            }
        }
        $score
    }

    end
    {

    }
}
