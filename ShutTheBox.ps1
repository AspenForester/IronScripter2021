$box = New-Box

<# # First Roll
$myroll = Get-DieRoll -die 6 -Count 2
$myroll
$rollsum = $myroll | Measure-Object -sum | select-object -ExpandProperty Sum #>

do
{
    # How many dice should be rolled?
    # - at some point the option to roll one die needs to be offered
    $diceToRoll = 2

    $myroll = Get-DieRoll -die 6 -Count $diceToRoll
    $myroll
    $rollsum = $myroll | Measure-Object -sum | select-object -ExpandProperty Sum

    do # Moves are valid
    {
        do # sum of proposed moves
        {
            # Need to warn of invalid choice if needed.
            # write-Warning -Message "Your moves [$($mymoves -join(', '))] don't add up to [$movesum]"

            $mymoves = Read-Host "Which numbers do you want to close?"
            $mymoves = [int[]]($mymoves -split (","))
            $movesum = $mymoves | Measure-Object -sum | select-object -ExpandProperty Sum
        } until ($movesum -eq $rollsum)

        # Need to test the proposed moves!

        $movesAreValid = Test-BoxMove -Move $mymoves -Box $box
    } until ($movesAreValid )

    # Apply the moves
    foreach ($choice in $mymoves)
    {
        $box.$choice = $true
    }
    $box

} until ( Test-BoxWin -Box $box )# Game Over condition
# Get Moves


#Read-Host -Prompt "How Many Dice to roll? (1/2)"
