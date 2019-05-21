git secrets --install $env:USERPROFILE/.git-templates/git-secrets
git secrets --register-aws --global

# Add hooks to all your local repositories.
git config --global init.templateDir $env:USERPROFILE/.git-templates/git-secrets
