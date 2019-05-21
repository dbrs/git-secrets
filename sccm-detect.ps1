$isGitInstalled = $null -ne ( (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*) + (Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*) | Where-Object { $null -ne $_.DisplayName -and $_.Displayname.Contains('Git') })
if (-Not $isGitInstalled){
    # If git is not installed we can't install hooks. So exit and indicate successful install.
    Write-Output "Git not installed. No need to install git-hook. Exiting."
}
else {
    # if git is installed, then check if hooks are installed.
    if(test-path $env:USERPROFILE\.git-templates\git-secrets){
        Write-Output "git-secrets template already installed. Exiting."
    }
    # If git is installed, and git-secrets directory doesn't exist, there will be no output, which indicates to powershell that the application is not installed.
    # So an install will be attempted
}