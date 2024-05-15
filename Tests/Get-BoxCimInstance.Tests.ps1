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
    Context 'an Object of Specific type' {
        BeforeAll {
            Mock New-CimSession -MockWith { $true } # { New-MockObject -Type 'Microsoft.Management.Infrastructure.CimSession' }
            Mock Get-CimInstance -MockWith { (Get-Content -Path (Join-Path $TestsPath -ChildPath Assets.txt)) } -RemoveParameterType CimSession
        }

        It 'returns three items' {
            (Get-BoxCimInstance).count | Should -Be 3
        }

        It 'returns the right first item' {
            (Get-BoxCimInstance)[0] | Should -Be 'Lorem'
        }
    }

    Context 'a command suppressing input typing' {
        BeforeAll {
            Mock New-CimSession -MockWith { New-MockObject -Type 'Microsoft.Management.Infrastructure.CimSession' }
            Mock Get-CimInstance -MockWith { (Get-Content -Path (Join-Path $TestsPath -ChildPath Assets.txt)) }
        }

        It 'returns three items' {
            (Get-BoxCimInstance).count | Should -Be 3
        }

        It 'returns the right first item' {
            (Get-BoxCimInstance)[1] | Should -Be 'Ipsum'
        }
    }
}
