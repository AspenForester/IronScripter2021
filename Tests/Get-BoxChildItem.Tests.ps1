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
}

Describe 'Mocking' {
    BeforeAll {
        Mock Get-ChildItem -MockWith { (Get-Content -Path (Join-Path $TestsPath -ChildPath Assets.txt)) }
    }

    It 'returns three items' {
        (Get-BoxChildItem).count | Should -Be 3
    }

    It 'returns "Dolar" as the last item' {
        (Get-BoxChildItem)[-1] | Should -Be 'Dolar'
    }
}
