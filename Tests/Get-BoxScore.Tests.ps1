BeforeAll {
    # This works because the functions are in the same dir as
    # the Tests directory.
    # This is not the case in a module structure

    $TestsPath = Split-Path -Path $PSCommandPath -Parent

    $thisSubjectFunction = $PSCommandPath.Replace('Tests\', '').Replace('Tests.ps1', 'ps1')
    . $thisSubjectFunction

    $ModuleRootPath = Split-Path $TestsPath -Parent

    $ModulePublicPath = Join-Path -Path $ModuleRootPath -ChildPath (Split-Path $ModuleRootPath -Leaf) -AdditionalChildPath 'Public'
    Write-Host $ModulePublicPath

    $boxfunctionpath = Join-Path $ModuleRootPath -ChildPath 'New-Box.ps1'
    . $boxfunctionpath
}

Describe 'Get box game score' {
    BeforeEach {
        $box = new-box
    }

    Context 'of a new box' {
        It 'has a score of 45' {
            Get-BoxScore -box $box | Should -Be 45
        }

    }

    Context 'with the last three doors shut' {
        It 'has a score of 21' {
            $box.7 = $box.8 = $box.9 = $true
            Get-BoxScore -box $box | Should -Be 21
        }
    }

    Context 'with the first three doors shut' {
        It 'has a score of 39' {
            $box.1 = $box.2 = $box.3 = $true
            Get-BoxScore -box $box | Should -Be 39
        }
    }
}
