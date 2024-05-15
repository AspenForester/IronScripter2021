# Assets tests
BeforeAll {
    # This works because the functions are in the same dir as
    # the Tests directory.
    # This is not the case in a module structure

    $TestsPath = Split-Path -Path $PSCommandPath -Parent

    $ModuleRootPath = Split-Path $TestsPath -Parent

    $ModulePublicPath = Join-Path -Path $ModuleRootPath -ChildPath (Split-Path $ModuleRootPath -Leaf) -AdditionalChildPath 'Public'
}

Describe 'Testing Test Assets' {
    It 'finds the directory <TestsPath>' {
        Test-Path $TestsPath | Should -BeTrue
    }

    It 'Finds the Test Asset file' {
        $AssestPath = Join-Path -Path $TestsPath -ChildPath 'Assets.txt'
        Test-Path $AssestPath | Should -BeTrue
    }

    It 'Gets the contents of the Asset file' {
        { Get-Content -Path (Join-Path -Path $TestsPath -ChildPath 'Assets.txt') } | Should -Not -Throw
    }

    It 'Gets the right number of lines' {
        $Content = Get-Content -Path (Join-Path -Path $TestsPath -ChildPath 'Assets.txt')
        $Content.count | Should -Be 3
    }
}
