$servernames = Get-Content .\Inputs\AllDDCs.txt
foreach ($server in $servernames){
    Describe "$server" {
         It "Returns <expected> (<name>)" -TestCases @(
            @{Name="CitrixAnalytics";Expected='Running'}
            @{Name="CitrixAppLibrary";Expected='Running'}
            @{Name="CitrixBrokerService";Expected='Running'}
            @{Name="CitrixConfigSyncService";Expected='Running'}
            @{Name="CitrixConfigurationLogging";Expected='Running'}
            @{Name="CitrixDelegatedAdmin";Expected='Running'}
            @{Name="CitrixEnvTest";Expected='Running'}
            @{Name="CitrixHighAvailabilityService";Expected='Running'}
            @{Name="CitrixHostService";Expected='Running'}
            @{Name="CitrixMachineCreationService";Expected='Running'}
            @{Name="CitrixMonitor";Expected='Running'}
            @{Name="CitrixOrchestration";Expected='Running'}
            @{Name="CitrixPrivilegedService";Expected='Running'}
            @{Name="CitrixStorefront";Expected='Running'}
            @{Name="CitrixTelemetryService";Expected='Running'}
            @{Name='CitrixTrust';Expected='Running'}
            @{Name='XaXdCloudProxy';Expected='Running'}
        ){
            (Get-Service -ComputerName $server -Name $name).Status | Should -Be $expected
        } 
        It "$Server is pingable via ICMP" {
            (Test-NetConnection -ComputerName $server).PingSucceeded | Should -Be $true
        }
        It "$Server is pingable via Port 80" {
            (Test-NetConnection -ComputerName $server -port 80).TCPTestSucceeded | Should -Be $true
        }
        It "ADIdentity Service Status Check" {
            Get-AcctServiceStatus -AdminAddress $server | Should -Be "OK"
        }
        It "ADelegatedAdmin Service Status Check" {
            Get-AdminServiceStatus -AdminAddress $server | Should -Be "OK"
        }
        It "Broker Service Status Check" {
            Get-BrokerServiceStatus -AdminAddress $server | Should -Be "OK"
        }
        It "Host Service Status Check" {
            Get-HypServiceStatus -AdminAddress $server | Should -Be "OK"
        }
        It "MachineCreation Service Status Check" {
            Get-ProvServiceStatus -AdminAddress $server | Should -Be "OK"
        }
    }
}