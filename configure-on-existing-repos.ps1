# Loop through all local drives on the computer
GET-WMIOBJECT -query "SELECT * from win32_logicaldisk where DriveType = '3'" | ForEach-Object {
    $driveLetter=$_.DeviceID

    Write-Output = "$driveLetter"
    Get-ChildItem -Path $driveLetter\ -Filter .git -Recurse -ErrorAction SilentlyContinue -Force | Select-Object @{ n = 'Folder'; e = { Convert-Path $_.PSParentPath } } | ForEach-Object {
        $repoDir=$_.Folder
        # Go to the repository Folder
        Set-Location -Path $repoDir
        
        Write-Output "Installing hook in repo: $repoDir"
        git secrets --install
        git secrets --register-aws
    }
}

Write-Output "Finished installing hooks on all repos"