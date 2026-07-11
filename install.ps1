#Requires -RunAsAdministrator
# Windows install script — pairs with install.sh for Linux/macOS
# Run from repo root: .\install.ps1

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

function Install-WingetPackage {
  param([string]$Id, [string]$Name)
  $installed = winget list --id $Id 2>$null | Select-String $Id
  if ($installed) {
    Write-Host "  $Name already installed, skipping"
  } else {
    Write-Host "  Installing $Name..."
    winget install --id $Id --silent --accept-package-agreements --accept-source-agreements
  }
}

function New-Symlink {
  param([string]$Target, [string]$Link)
  $parent = Split-Path -Parent $Link
  if (!(Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
  if (Test-Path $Link) { Remove-Item $Link -Force -Recurse }
  New-Item -ItemType SymbolicLink -Path $Link -Target $Target | Out-Null
}

Write-Host "Installing packages..."
Install-WingetPackage "AmanThanvi.winghostty"          "winghostty"
Install-WingetPackage "Starship.Starship"               "starship"
Install-WingetPackage "CoreyButler.NVMforWindows"       "nvm for windows"
Install-WingetPackage "Git.Git"                         "git"

Write-Host "Installing Node.js LTS..."
$nvmCmd = "$env:APPDATA\nvm\nvm.exe"
if (Test-Path $nvmCmd) {
  & $nvmCmd install lts
  & $nvmCmd use lts
} else {
  Write-Warning "nvm not found at expected path — open a new shell and run: nvm install lts && nvm use lts"
}

Write-Host "Installing Claude Code..."
$claudeInstalled = npm list -g @anthropic-ai/claude-code 2>$null | Select-String "claude-code"
if (!$claudeInstalled) {
  npm install -g @anthropic-ai/claude-code
} else {
  Write-Host "  already installed, skipping"
}

Write-Host "Symlinking dotfiles..."

# Starship config — starship checks both %APPDATA% and ~/.config on Windows
$starshipTarget = "$ScriptDir\dotfiles\.config\starship.toml"
New-Symlink -Target $starshipTarget -Link "$env:USERPROFILE\.config\starship.toml"
Write-Host "  starship.toml -> ~/.config/starship.toml"

# winghostty config
# NOTE: verify this path when testing on Monday — winghostty may use a different
# location (e.g. %LOCALAPPDATA%\ghostty\config). Check: winghostty --config-path
$ghosttyTarget = "$ScriptDir\dotfiles\.config\ghostty\config"
New-Symlink -Target $ghosttyTarget -Link "$env:APPDATA\ghostty\config"
Write-Host "  ghostty/config -> %APPDATA%\ghostty\config"

# Git config
New-Symlink -Target "$ScriptDir\dotfiles\.gitconfig" -Link "$env:USERPROFILE\.gitconfig"
Write-Host "  .gitconfig -> ~/.gitconfig"

Write-Host "Setting up PowerShell profile..."
$profileDir = Split-Path -Parent $PROFILE
if (!(Test-Path $profileDir)) { New-Item -ItemType Directory -Path $profileDir -Force | Out-Null }
$starshipLine = 'Invoke-Expression (&starship init powershell)'
if (!(Test-Path $PROFILE) -or !(Select-String -Path $PROFILE -Pattern "starship init" -Quiet)) {
  Add-Content -Path $PROFILE -Value "`n$starshipLine"
  Write-Host "  added starship init to $PROFILE"
} else {
  Write-Host "  starship already in profile, skipping"
}

Write-Host ""
Write-Host "Done! Open winghostty to get started."
Write-Host ""
Write-Host "FIRST RUN CHECKLIST:"
Write-Host "  1. Verify winghostty config path (run: winghostty --config-path or check docs)"
Write-Host "  2. Install FiraCode Nerd Font manually from nerdfonts.com and set in winghostty"
Write-Host "  3. Run: nvm install lts && nvm use lts  (if nvm wasn't on PATH yet)"
