Import-Module -Name Pester

Invoke-Pester -Path ".\Tests\*.Tests.ps1" -OutputFile ".\XML\AllTestResults.xml" -OutputFormat NUnitXml
.\ReportUnit.exe ".\XML\AllTestResults.xml" ".\AllTestResults.html"