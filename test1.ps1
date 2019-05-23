[Environment+SpecialFolder]::GetNames([Environment+SpecialFolder]) | ForEach-Object {
    [Environment]::GetFolderPath($_) | Select-String -Pattern '^(?!.:.+$).*' | Select-String -Pattern '.+' | ForEach-Object {
        Write-Host "Scanning Folder: " $_
    }
}
