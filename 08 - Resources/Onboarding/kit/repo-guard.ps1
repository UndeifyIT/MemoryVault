<#
.SYNOPSIS
  Installs the Undeify secret-scan pre-commit hook into a project repo, on this machine only.

.DESCRIPTION
  Copies the vault's .githooks\pre-commit to <repo>\.git\hooks\pre-commit. That file is not tracked by Git,
  so nothing in the repo's own history or files changes, and each teammate runs this for themselves.
  It never overwrites an existing hook, and it stops if the repo sets its own core.hooksPath.

  powershell -ExecutionPolicy Bypass -File repo-guard.ps1 -Repo C:\path\to\repo
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$Repo,
  [string]$VaultDir = (Join-Path $HOME 'Undeify')
)
$ErrorActionPreference = 'Stop'
$src = Join-Path $VaultDir '.githooks\pre-commit'
if (-not (Test-Path $src)) { throw "Secret-scan hook not found at $src. Is the Undeify vault at $VaultDir?" }
$gitDir = Join-Path $Repo '.git'
if (-not (Test-Path $gitDir -PathType Container)) { throw "$Repo is not the top of a Git repo (no .git folder)." }
$hp = git -C $Repo config core.hooksPath
if ($hp) { Write-Host "!!  This repo sets core.hooksPath ($hp), so I left it alone. Add the scan to that hooks folder by hand." -ForegroundColor Yellow; return }
$dst = Join-Path $gitDir 'hooks\pre-commit'
if (Test-Path $dst) {
  $same = (Get-FileHash $src).Hash -eq (Get-FileHash $dst).Hash
  if ($same) { Write-Host '==> The secret scan is already installed in this repo.' -ForegroundColor Cyan }
  else { Write-Host '!!  This repo already has a different pre-commit hook, so I left it alone.' -ForegroundColor Yellow }
  return
}
New-Item -ItemType Directory -Force -Path (Split-Path $dst) | Out-Null
Copy-Item $src $dst
Write-Host "==> Installed the secret scan at $dst" -ForegroundColor Cyan
Write-Host '    It blocks commits that add keys, tokens, .env or key files. To clear a false positive add "allowlist secret" to the line.'
