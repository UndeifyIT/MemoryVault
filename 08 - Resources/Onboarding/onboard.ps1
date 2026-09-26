<#
.SYNOPSIS
  Sets up an Undeify team member's Windows machine: shared vault, Obsidian, Junior's boot file,
  Claude Code memory redirect, and a "Chat with Junior" Desktop launcher.

.DESCRIPTION
  Safe to re-run. It never overwrites an existing CLAUDE.md, MEMORY.md or launcher, and it backs up
  Obsidian's obsidian.json before adding the vault to it. See Onboarding.md in this folder.

  Run it with:
    powershell -ExecutionPolicy Bypass -File "$HOME\Undeify\08 - Resources\Onboarding\onboard.ps1"
#>
[CmdletBinding()]
param(
  [string]$Name,
  [string]$RepoUrl,
  [string]$VaultDir = (Join-Path $HOME 'Undeify'),
  [string]$AgentDir = (Join-Path $HOME 'my-agent'),
  [string]$ObsidianConfigDir = (Join-Path $env:APPDATA 'obsidian'),
  [string]$ClaudeProjectsDir = (Join-Path $HOME '.claude\projects'),
  [string]$DesktopDir = [Environment]::GetFolderPath('Desktop')
)

$ErrorActionPreference = 'Stop'
$utf8 = New-Object System.Text.UTF8Encoding($false)

function Say($m)  { Write-Host "==> $m" -ForegroundColor Cyan }
function Warn($m) { Write-Host "!!  $m" -ForegroundColor Yellow }
function Have($c) { [bool](Get-Command $c -ErrorAction SilentlyContinue) }
function Refresh-Path {
  $env:Path = [Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [Environment]::GetEnvironmentVariable('Path','User')
}

# 0. Who is this for
if (-not $Name) { $Name = Read-Host "What's your first name?" }
$Name = $Name.Trim()
if ($Name -notmatch "^[\p{L} .'-]{1,40}$") { throw "That name has characters I won't put in a config file. Use letters only." }

# 1. Git
if (-not (Have git)) {
  if (-not (Have winget)) { throw "Git is missing and winget isn't available. Install Git from https://git-scm.com and run this again." }
  Say 'Installing Git...'
  winget install --id Git.Git -e --silent --accept-package-agreements --accept-source-agreements
  Refresh-Path
  if (-not (Have git)) { throw 'Git installed but this window cannot see it yet. Close this window, open a new PowerShell, and run the script again.' }
}

# 2. The vault
if (Test-Path (Join-Path $VaultDir '.git')) {
  Say "Vault already at $VaultDir. Pulling the latest..."
  git -C $VaultDir pull --ff-only
  if ($LASTEXITCODE -ne 0) { throw 'git pull failed. Resolve it in the vault folder, then run this again.' }
} else {
  if ((Test-Path $VaultDir) -and (Get-ChildItem $VaultDir -Force | Select-Object -First 1)) {
    throw "$VaultDir exists and isn't the Undeify vault. Move it or pass -VaultDir with another path."
  }
  if (-not $RepoUrl) { $RepoUrl = Read-Host 'Paste the private vault repo URL' }
  Say "Cloning the vault to $VaultDir (GitHub may ask you to sign in)..."
  git clone $RepoUrl $VaultDir
  if ($LASTEXITCODE -ne 0) { throw 'git clone failed. Check the URL and that you have been added to the repo.' }
}
$tplPath = Join-Path $VaultDir '08 - Resources\Onboarding\CLAUDE.template.txt'
if (-not (Test-Path $tplPath)) { throw "Boot-file template not found at $tplPath. Is this the Undeify vault?" }

# 3. Obsidian
$obsExe = Join-Path $env:LOCALAPPDATA 'Programs\Obsidian\Obsidian.exe'
if (Test-Path $obsExe) {
  Say 'Obsidian is already installed.'
} elseif (Have winget) {
  Say 'Installing Obsidian...'
  winget install --id Obsidian.Obsidian --silent --accept-package-agreements --accept-source-agreements
} else {
  Warn 'winget is not available. Install Obsidian from https://obsidian.md, then run this script again.'
}

# 4. Junior's boot file
New-Item -ItemType Directory -Force -Path $AgentDir | Out-Null
$claudeMd = Join-Path $AgentDir 'CLAUDE.md'
$boot = (Get-Content -Raw -Encoding UTF8 $tplPath).Replace('{{NAME}}', $Name).Replace('{{VAULT_PATH}}', $VaultDir)
if (Test-Path $claudeMd) {
  if ((Get-Content -Raw -Encoding UTF8 $claudeMd) -ceq $boot) {
    Say 'Junior''s boot file is already up to date.'
  } else {
    [IO.File]::WriteAllText("$claudeMd.new", $boot, $utf8)
    Warn "A different CLAUDE.md already exists in $AgentDir, so I left it alone. The current template is CLAUDE.md.new; compare and merge by hand."
  }
} else {
  [IO.File]::WriteAllText($claudeMd, $boot, $utf8)
  Say "Wrote Junior's boot file to $claudeMd"
}

# 5. One memory, not two: point Claude Code's own memory at the vault
$projName = $AgentDir -replace '[^a-zA-Z0-9]', '-'
$memDir = Join-Path $ClaudeProjectsDir "$projName\memory"
$memFile = Join-Path $memDir 'MEMORY.md'
if (Test-Path $memFile) {
  Say 'Claude Code memory redirect already exists; leaving it.'
} else {
  New-Item -ItemType Directory -Force -Path $memDir | Out-Null
  $redirect = @'
There is no separate memory layer here. The single source of truth is the Obsidian vault.

Sources of truth, in load order:
- CLAUDE.md (boot config, in the working folder — not the vault) — startup sequence + the rules that can't lapse.
- VAULT-INDEX.md (vault root) — profile, full rules, the system map.
- Everything else lives in its contextual home in the vault.

To remember something, write it to its place in the vault, never here.
'@
  [IO.File]::WriteAllText($memFile, $redirect, $utf8)
  Say "Wrote the memory redirect to $memFile"
}

# 6. Register the vault with Obsidian
$cfgFile = Join-Path $ObsidianConfigDir 'obsidian.json'
$defaultCfg = ($ObsidianConfigDir -eq (Join-Path $env:APPDATA 'obsidian'))
if ($defaultCfg -and (Get-Process -Name Obsidian -ErrorAction SilentlyContinue)) {
  throw 'Obsidian is running. Close it completely (check the system tray) and run this script again.'
}
New-Item -ItemType Directory -Force -Path $ObsidianConfigDir | Out-Null
if (Test-Path $cfgFile) {
  Copy-Item $cfgFile "$cfgFile.bak" -Force
  $cfg = Get-Content -Raw $cfgFile | ConvertFrom-Json
} else {
  $cfg = [pscustomobject]@{ vaults = [pscustomobject]@{} }
}
if (-not $cfg.PSObject.Properties['vaults']) { $cfg | Add-Member -NotePropertyName vaults -NotePropertyValue ([pscustomobject]@{}) }
$already = $cfg.vaults.PSObject.Properties | Where-Object { $_.Value.path -eq $VaultDir }
if ($already) {
  Say 'Vault is already registered with Obsidian.'
} else {
  $id = -join ((1..16) | ForEach-Object { '{0:x}' -f (Get-Random -Maximum 16) })
  $ts = [int64][DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()
  $cfg.vaults | Add-Member -NotePropertyName $id -NotePropertyValue ([pscustomobject]@{ path = $VaultDir; ts = $ts; open = $true })
  [IO.File]::WriteAllText($cfgFile, ($cfg | ConvertTo-Json -Depth 6), $utf8)
  # Verify by reading the path back out of the file and checking it exists on disk
  $back = Get-Content -Raw $cfgFile | ConvertFrom-Json
  $entry = $back.vaults.PSObject.Properties | Where-Object { $_.Value.path -eq $VaultDir }
  if (-not $entry -or -not (Test-Path $entry.Value.path)) {
    if (Test-Path "$cfgFile.bak") { Copy-Item "$cfgFile.bak" $cfgFile -Force }
    throw 'Could not verify the Obsidian registration, so I restored the backup. Open Obsidian and use "Open folder as vault" instead.'
  }
  Say 'Registered the vault with Obsidian.'
}

# 7. Desktop launcher
$launcher = Join-Path $DesktopDir 'Chat with Junior.bat'
if (Test-Path $launcher) {
  Say 'Launcher already on the Desktop.'
} else {
  [IO.File]::WriteAllText($launcher, "@echo off`r`ncd /d `"$AgentDir`"`r`nclaude`r`n", $utf8)
  Say "Created $launcher"
}

# 8. Final checks and next steps
Write-Host ''
if (-not (Have claude)) {
  Warn 'Claude Code is not installed (or not on PATH). Install it, sign in once, then use the launcher.'
}
if (-not (git config --global user.name)) {
  Warn 'Git has no name set. Run:  git config --global user.name "Your Name"  and  git config --global user.email "you@example.com"'
}
Write-Host "Done, $Name." -ForegroundColor Green
Write-Host '  1. Open Obsidian. It should open straight into the Undeify vault.'
Write-Host '  2. Double-click "Chat with Junior" on your Desktop. Junior will introduce itself and ask a few questions to write your profile into the vault.'
Write-Host "  3. If Junior doesn't greet you by name, tell Isaac."
