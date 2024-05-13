# None of these tests are really necessary
# given that the function being tested uses only core
# functionality and commands

BeforeAll {
        . ($PSCommandPath.Replace("Tests\","").Replace("Tests.ps1","ps1"))
    }
Describe "Die Rolls" {
    $DieHash = (
        @{
            DieSides = 4
        },
        @{
            DieSides = 6
        },
        @{
            DieSides = 8
        },
        @{
            DieSides = 10
        },
        @{
            DieSides = 12
        },
        @{
            DieSides = 20
        }

    )

    Context "D<DieSides>" -ForEach $DieHash {

        BeforeAll {
            $rollcount = 1000
            $results = Get-dieroll -die $diesides -count $rollcount
            $Script:ThisAverage = ((1..$diesides) | Measure-Object -Average).Average
        }

        It "returns 100 rolls" {
            $results.count | should -BeExactly $rollcount
        }

        It "has a max of $diesides" {
            ($results | Measure-Object -Maximum).Maximum | Should -Be $diesides
        }

        It "has a min of 1" {
            ($results | Measure-Object -Minimum).Minimum | Should -Be 1
        }

        It "has an average of <ThisAverage> +/- 10%" {
            ($results | Measure-Object -Average).Average | Should -BeGreaterThan (0.9 * $ThisAverage)
            ($results | Measure-Object -Average).Average | Should -BeLessThan (1.1 * $ThisAverage)
        }
    }
}
