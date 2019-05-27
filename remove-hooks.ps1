Function Clean-Location {
    Param(
        [Parameter(Mandatory=$True)]
        [string]$location
    )
    Begin {
        Write-Host "Scanning Location: $location"
        Get-ChildItem -Path $location\ -Filter .git -Recurse -ErrorAction SilentlyContinue -Force | Select-Object @{ n = 'Folder'; e = { Convert-Path $_.PSParentPath } } | ForEach-Object {
            $repoDir=$_.Folder
            
            Write-Host -NoNewline "Removing hooks from repo: $repoDir"
            $hooksRemoved = 0
            if (Test-Path "$repoDir\.git\hooks\commit-msg"){
                Remove-Item -Path "$repoDir\.git\hooks\commit-msg"
                Write-Host -NoNewline "."
                $hooksRemoved += 1
            }
            if (Test-Path "$repoDir\.git\hooks\pre-commit"){
                Remove-Item -Path "$repoDir\.git\hooks\pre-commit"
                Write-Host -NoNewline "."
                $hooksRemoved += 1
            }
            if (Test-Path "$repoDir\.git\hooks\prepare-commit-msg"){
                Remove-Item -Path "$repoDir\.git\hooks\prepare-commit-msg"
                Write-Host -NoNewline "."
                $hooksRemoved += 1
            }
            if ($hooksRemoved -eq 0){
                Write-Host " - No hooks found"
            } else {
                Write-Host "Done. $hooksRemoved hooks removed."
            }
        }
        Write-Output "----------"
    }
}


# Loop through all local drives on the computer
GET-WMIOBJECT -query "SELECT * from win32_logicaldisk where DriveType = '3'" | ForEach-Object {
    $driveLetter=$_.DeviceID
    Clean-Location $driveLetter
}

# Also install for redirected folders
[Environment+SpecialFolder]::GetNames([Environment+SpecialFolder]) | ForEach-Object {
    [Environment]::GetFolderPath($_) | Select-String -Pattern '^(?!.:.+$).*' | Select-String -Pattern '.+' | ForEach-Object {
        $folder=$_
        Clean-Location $folder
    }
}

Write-Output "Finished removing hooks from all repos"