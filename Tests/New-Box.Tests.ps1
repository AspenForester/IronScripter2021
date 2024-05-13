BeforeAll {
    . ($PSCommandPath.Replace("Tests\","").Replace("Tests.ps1","ps1"))
}

Describe "New Box" {
    Context "Make a new Box" {
        BeforeAll {
            $ThisBox = New-Box
        }

        it "Returns a single object" {
            $ThisBox.count | Should -be 1
        }

        It "Returns a PSCustomObject" {
            $ThisBox | Should -BeOfType [PSCustomObject]
        }

        It "Returns an object with 9 properties" {
            ($foo | Get-Member -MemberType NoteProperty).count | Should -Be 9
        }
    }
}
