
    $servernames = Get-Content .\Inputs\Directors.txt

foreach ($server in $servernames){
    Describe "$server" {      
        It "$server is pingable via ICMP" {
            (Test-NetConnection -ComputerName $server).PingSucceeded | Should -Be $true
        }
        It "$server is pingable via port 80" {
            (Test-NetConnection -ComputerName $server -port 80).TcpTestSucceeded | Should -Be $true
        }
        It "$server is pingable via port 443" {
            (Test-NetConnection -ComputerName $server -port 443).TcpTestSucceeded | Should -Be $true
        }
        It "Returns <expected> (<name>)" -TestCases @(
            @{Name="W3svc";Expected='Running'}
        ){
            (Get-Service -ComputerName $server -Name $name).Status | Should -Be $Expected
        }
    }
}