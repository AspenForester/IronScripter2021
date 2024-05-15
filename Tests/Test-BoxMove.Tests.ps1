BeforeAll {
    # This works because the functions are in the same dir as
    # the Tests directory.
    # This is not the case in a module structure

    $TestsPath = Split-Path -Path $PSCommandPath -Parent

    $thisSubjectFunction = $PSCommandPath.Replace('Tests\', '').Replace('Tests.ps1', 'ps1')
    . $thisSubjectFunction

    $ModuleRootPath = Split-Path $TestsPath -Parent
    Write-Host $ModuleRootPath
    $ModulePublicPath = Join-Path -Path $ModuleRootPath -ChildPath (Split-Path $ModuleRootPath -Leaf) -AdditionalChildPath 'Public'
    $Newboxpath = Join-Path $ModuleRootPath -ChildPath '.\New-Box.ps1'
    . $Newboxpath

}

Describe 'Testing Box Moves' {
    Context 'Checking a single door' {
        BeforeAll {
            $ThisBox = New-Box
        }

        It 'will be a valid to make one move on a new box' {
            Test-BoxMove -Move 1 -Box $ThisBox | Should -BeTrue
        }

        It 'will be an invalid move when door 1 is already closed' {
            $thisbox.1 = $true # Close door 1
            Test-BoxMove -Move 1 -Box $ThisBox | Should -BeFalse
        }
    }

    Context 'Checking more than one move' {
        BeforeAll {
            $ThisBox = New-Box
        }

        It 'will pass when all moves in the set are valid' {
            Test-BoxMove -Move 1, 2, 3 -Box $ThisBox | Should -BeTrue
        }

        It 'will fail when any one move in the set is already closed' {
            $ThisBox.8 = $true
            Test-BoxMove -Move 7, 8, 9 -Box $ThisBox | Should -BeFalse
        }
    }
}
