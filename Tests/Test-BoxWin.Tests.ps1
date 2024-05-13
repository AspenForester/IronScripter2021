BeforeAll {
    . ($PSCommandPath.Replace("Tests\","").Replace("Tests.ps1","ps1"))
}

Describe "Testing for a win" {
    BeforeAll {
        $ThisBox = New-Box
    }

    It "is not a win if any door is open (False)" {
        Test-BoxWin -Box $ThisBox | Should -BeFalse
    }

    It "is a win if all doors are closed (True)" {
        $ThisBox.1 = $ThisBox.2 = $ThisBox.3 = $ThisBox.4 = $ThisBox.5 = $ThisBox.6 = $ThisBox.7 = $ThisBox.8 = $ThisBox.9 = $true
        Test-BoxWin -Box $ThisBox | Should -BeTrue
    }
}
