BeforeAll {
    . ($PSCommandPath.Replace("Tests\", "").Replace("Tests.ps1", "ps1"))
}

Describe "Testing Box Moves" {
    Context "Checking a single door" {
        BeforeAll {
            $ThisBox = New-Box
        }

        it "will be a valid to make one move on a new box" {
            Test-BoxMove -Move 1 -Box $ThisBox | Should -BeTrue
        }

        it "will be an invalid move when door 1 is already closed" {
            $thisbox.1 = $true # Close door 1
            Test-BoxMove -Move 1 -Box $ThisBox | Should -BeFalse
        }
    }

    Context "Checking more than one move" {
        BeforeAll {
            $ThisBox = New-Box
        }

        it "will pass when all moves in the set are valid" {
            Test-BoxMove -Move 1,2,3 -Box $ThisBox | Should -BeTrue
        }

        it "will fail when any one move in the set is already closed" {
            $ThisBox.8 = $true
            Test-BoxMove -Move 7,8,9 -Box $ThisBox | Should -BeFalse
        }
    }
}
