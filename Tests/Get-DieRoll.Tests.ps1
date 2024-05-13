# None of these tests are really necessary
# given that the function being tested uses only core
# functionality and commands

BeforeAll {
    . ($PSCommandPath.Replace("Tests\", "").Replace("Tests.ps1", "ps1"))
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

        It "returns 1000 rolls" {
            $results.count | Should -BeExactly $rollcount
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

    # you could change this to "Returns the correct number of rolls"
    # and skip the additional sub-contexts
    Context "Number of rolls" {
        Context "Player asks for zero rolls" {
            It "returns zero die rolls" {
                Get-DieRoll -Count 0 | Should -BeNullOrEmpty
            }
        }
        Context "Player asks for one roll" {
            It "returns one die roll" {
                (Get-DieRoll -Count 1).count | Should -Be 1
            }
        }
        Context "Player asks for five rolls" {
            It "returns five die roll" {
                (Get-DieRoll -Count 5).count | Should -Be 5
            }
        }
    }
}
