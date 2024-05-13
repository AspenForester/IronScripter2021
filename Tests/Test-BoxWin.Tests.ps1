BeforeAll {
    $thisSubjectFunction = $PSCommandPath.Replace("Tests\", "").Replace("Tests.ps1", "ps1")
    . $thisSubjectFunction

    $functionPath = Split-Path $thisSubjectFunction -Parent
    $Newboxpath = Join-Path $functionPath -ChildPath ".\New-Box.ps1"
    . $Newboxpath
}

Describe "Testing for a win" {
    BeforeAll {
        $ThisBox = New-Box
    }

    Context "Any door is open (False)" {
        It "is not a win" {
            Test-BoxWin -Box $ThisBox | Should -BeFalse
        }
    }

    Context "All doors are closed (True)" {
        It "is a win" {
            $ThisBox.1 = $ThisBox.2 = $ThisBox.3 = $ThisBox.4 = $ThisBox.5 = $ThisBox.6 = $ThisBox.7 = $ThisBox.8 = $ThisBox.9 = $true
            Test-BoxWin -Box $ThisBox | Should -BeTrue
        }
    }
}
