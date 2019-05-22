ts=Get-Date -Format o | foreach {$_ -replace ":", "."}
.\install-secrets.ps1 | Tee-Object -FilePath "$env:TEMP\install-and-hook.$ts.log"
.\configure-hooks-template.ps1 | Tee-Object -FilePath "$env:TEMP\install-and-hook.$ts.log"
.\configure-on-existing-repos.ps1 | Tee-Object -FilePath "$env:TEMP\install-and-hook.$ts.log"