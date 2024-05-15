$box = New-Box

<# # First Roll
$myroll = Get-DieRoll -die 6 -Count 2
$myroll
$rollsum = $myroll | Measure-Object -sum | select-object -ExpandProperty Sum #>
Write-Host 'Starting a new game'
do
{
    # How many dice should be rolled?
    # - at some point the option to roll one die needs to be offered
    # - Once 7, 8, & 9 are closed, one die *may* be rolled
    $diceToRoll = 2

    $myroll = Get-DieRoll -die 6 -Count $diceToRoll
    Write-Host "You rolled $($myroll.split(', '))"
    $rollsum = $myroll | Measure-Object -Sum | Select-Object -ExpandProperty Sum

    do # Moves are valid
    {
        # Are the rolls too high for the current state of the game?

        do # sum of proposed moves
        {
            # Need to warn of invalid choice if needed.
            # write-Warning -Message "Your moves [$($mymoves -join(', '))] don't add up to [$movesum]"

            $mymoves = Read-Host 'Which numbers do you want to close?'
            $mymoves = [int[]]($mymoves -split (','))
            $movesum = $mymoves | Measure-Object -Sum | Select-Object -ExpandProperty Sum
        } until ($movesum -eq $rollsum)

        # Need to test the proposed moves!
        $movesAreValid = Test-BoxMove -Move $mymoves -Box $box

        # If the roll sum is greater than the highest sum of open doors, then
        # the player is stuck.

        # We can still get stuck if there are no valid moves.
    } until ( $movesAreValid -or $rollIsTooHigh)

    # Apply the moves
    foreach ($choice in $mymoves)
    {
        $box.$choice = $true
    }
    $box

} until ( Test-BoxWin -Box $box )# Game Over condition
# Get Moves

# Score is the sum of the open doors
$Score = Get-BoxScore -Box $box

#Read-Host -Prompt "How Many Dice to roll? (1/2)"
