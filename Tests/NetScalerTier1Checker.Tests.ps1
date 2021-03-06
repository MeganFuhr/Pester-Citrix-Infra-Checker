    $Tier1NSs = Get-Content -Path .\Inputs\Tier1NSs.txt

Describe "ADC Tier 1 Management Network"{
    foreach ($NS in $Tier1NSs) {    
        It "$NS pingable via ICMP" {
            (Test-NetConnection -ComputerName $NS$domain).PingSucceeded | Should -Be $true
        }    
    }
}