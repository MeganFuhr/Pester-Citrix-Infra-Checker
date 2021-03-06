
    $Tier2NSs = Get-Content -Path .\Inputs\Tier2NSs.txt
    $SFCallBacks = Get-Content -Path .\Inputs\Tier2NSsCallback.txt

Describe "ADC Tier 2 Management Network"{
    foreach ($NS in $Tier2NSs) {    
        It "$NS pingable via ICMP" {
            (Test-NetConnection -ComputerName $NS$domain).PingSucceeded | Should -Be $true
        }    
    }
    foreach ($CB in $SFCallBacks) {
        It "$CB response = 200" {
            (Invoke-WebRequest -URI $CB -Method Get).StatusCode | Should -Be '200'
        } 
    }
}