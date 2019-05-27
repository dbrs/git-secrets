Param([string]$InstallationDirectory = $($Env:USERPROFILE + "\.git-secrets"))

Write-Host "Checking to see if installation directory exists..."
if (Test-Path $InstallationDirectory)
{
    Write-Host "Installation directory exists."
    Write-Host "Removing files."
    Remove-Item -Path "$InstallationDirectory\git-secrets" -ErrorAction Ignore
    Remove-Item -Path "$InstallationDirectory\git-secrets.1" -ErrorAction Ignore

    Remove-Item -Path $Env:USERPROFILE\.git-templates\git-secrets -Recurse -ErrorAction Ignore
    
    Write-Host "Unsetting git init.templatedir and secrets config"
    git config --global --unset-all init.templatedir
    git config --global --unset-all secrets.providers
    git config --global --unset-all secrets.patterns
    git config --global --unset-all secrets.allowed
}
else
{
    Write-Host "Installation directory does not exist."
}

