Write-Output "Installing git-secrets global template"
git secrets --install $env:USERPROFILE/.git-templates/git-secrets
Write-Output "Registering AWS secret detection globally"
git secrets --register-aws --global

# Add hooks to all your local repositories.
Write-Output "Adding hooks to all local repos"
git config --global init.templateDir $env:USERPROFILE/.git-templates/git-secrets
