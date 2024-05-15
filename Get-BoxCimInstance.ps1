function Get-BoxCimInstance
{
    param (

    )

    $cs = New-CimSession -ComputerName $env:COMPUTERNAME

    Get-CimInstance -CimSession $cs -ClassName win32_operatingsystem
}
